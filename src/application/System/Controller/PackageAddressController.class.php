<?php
/**
 * PakageAddress(收件地址)
 */
namespace System\Controller;

use Think\Controller;
use Common\Controller\ExcelController;

class PackageAddressController extends Controller {

    private $address_model;

    public function _initialize() {
        $this->address_model = D("Common/PackageAddress");
    }

    /**
     * 导出
     *
     * @author luchaonan 2017/03/03
     */
     public function export() {
        $params = func_get_args();
        $params = $params[0];
        // TODO
        $excel = new ExcelController();
        $xlsName  =  $params['controller'];
        $xlsCell  = $this->get_list_name();
        //$xlsCell  = array('label');
        $xlsData  = M($xlsName)->select();
        $regions = M('Regions')->getField('id,name');
        foreach($xlsData as $key=>$val){
            $xlsData[$key]['country_name'] = $regions[$val['country_id']];
            $xlsData[$key]['province_name'] = $regions[$val['province_id']];
            $xlsData[$key]['city_name'] = $regions[$val['city_id']];
            $xlsData[$key]['county_name'] = $regions[$val['county_id']];
        }
        $fileName = $xlsName. $params['params']['task_id'];
        $res = $excel->exportExcel($fileName, $xlsName, $xlsCell, $xlsData);
        $data['id'] = $params['params']['task_id'];
        if($res && $params) {
            $data['file_url'] = $res;
            $data['status'] = 1;
            //写入操作日志
            write_log(L('DATA_EXPORT')."PackageAddress".L('SUCCESS'));
        }else{
            $data['status'] = 0;
            
            //写入操作日志            
            write_log(L('DATA_EXPORT')."PackageAddress".L('FAILURE').":".L('CREATE_EXCEL_FAILURE'));
            $params['params']['error_reson'] = L('CREATE_EXCEL_FAILURE');
            $data['params'] = serialize($params);
        }
        if(M('Queue')->save($data)){
            return true;
        }
        //return true;
        //return $res;
        
    }

    /**
     * 导入
     *
     * @author luchaonan 2017/03/03
     */
    public function import() {
        //header("Content-type: text/html; charset=utf-8");
        $params = func_get_args();
        // TODO
        $params = $params[0];
        $info = $params['params']['info'];
        $excel = new ExcelController();
        $res = $excel->importExecl($info);

        $map['id'] = $params['params']['task_id'];
        //默认状态为成功
        $map['status'] = 1;

        if($error = $res['error']){
            $params['params']['error_reson'] = $error;
            $map['status'] = 0;
        }
        //print_r($res);
        $this->address_model->startTrans();
        if($res['data']){
            foreach($res['data'] as $value){
                for($i=3;$i<=$value['Rows'];$i++){
                    
                    for($j=0;$j<$value['Cols'];$j++){
                        $xlsCell  = $this->get_list_name();
                        $cellName = $value['Content'][2][$j];
                        $cellValue =  trim($value['Content'][$i][$j]); 
                        foreach($xlsCell as $key=>$vals){
                            if($cellName == $vals[0] || $cellName == $vals[1]){
                                $cellName = $vals[0];
                            }
                        }
                        $data[$cellName] = htmlspecialchars($cellValue);
                        array_walk_recursive($data,'think_filter');
                        
                    }
                    //判断是国内外
                    if($data['country_name'] == '中国'){
                        $data['is_abroad'] = 0;
                    }else{
                        $data['is_abroad'] = 1;
                    }
                    //将国家、省、城市、县的名字变为id
                    $country_id = M('Regions')->where("name='".$data['country_name']."'")->getField('id');
                    $province_id = M('Regions')->where("name='".$data['province_name']."'")->getField('id');
                    $city_id = M('Regions')->where("name='".$data['city_name']."'")->getField('id');
                    $county_id = M('Regions')->where("name='".$data['county_name']."'")->getField('id');
                    $data['country_id'] = $country_id ? $country_id : '';
                    $data['province_id'] = $province_id ? $province_id : '';
                    $data['city_id'] = $city_id ? $city_id : '';
                    $data['county_id'] = $county_id ? $county_id : '';
                        
                    unset($data['country_name']);
                    unset($data['province_name']);
                    unset($data['city_name']);
                    unset($data['county_name']);
                    //检验数据是否重复存在
                    $find = M($params['controller'])->where($data)->find();
        
                    if (!$find) {
                        // print_r($data);
                        //重新建数组并合并的原因是下面的time影响上面的find
                        $data2['create_time'] = time();
                        $data2['update_time'] = time();
                        $data3 = array_merge($data,$data2);
                        if(!(M($params['controller'])->add($data3))){
                            $this->address_model->rollback();
                            $map['status'] = 0; 
                            $params['params']['error_reson'] = L("THE").$i.L("ROW").L("FORMAT_ERROR");

                            break;
                        }
                    }

                }
            }
        }
        $this->address_model->commit();
        if($map['status'] == 0){
            $map['params'] = serialize($params);
            //写入操作日志            
            write_log(L('DATA_IMPORT')."PackageAddress".L('FAILURE').":".$params['params']['error_reson']);
        }else{   
            //写入操作日志
            write_log(L('DATA_IMPORT')."PackageAddress".L('SUCCESS'));
        }
        if(M('Queue')->save($map)){
            return true;
        }
    }

    /**
     * 得到每个表允许导入导出的中英文列名
     *
     * @author luchaonan 2017/03/03
     */
    public function get_list_name(){
        $xlsCell  = array(
            array('address_name','收件地址名称'),
            array('country_name','国家'),
            array('province_name','省'),
            array('city_name','城市'),
            array('county_name','县'),
            array('address_detail','详细地址'),
        );
        return $xlsCell;
    }

}
