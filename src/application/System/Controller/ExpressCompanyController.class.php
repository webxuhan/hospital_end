<?php
/**
 * 快递公司Controller
 *
 * @author Face 2017/01/10
 */

namespace System\Controller;

use Think\Controller;
use Common\Controller\ExcelController;
class ExpressCompanyController extends Controller {

    // 快递公司 Model
    private $ExpressCompanyModel;

    public function _initialize() {
        $this->ExpressCompanyModel = D("Common/ExpressCompany");
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
        foreach($xlsData as $key=>$val){
            if($val['express_type'] == 0){
                $xlsData[$key]['express_type'] = '国内';
            }else{
                $xlsData[$key]['express_type'] = '国际';
            }
            if($val['express_attr'] == 0){
                $xlsData[$key]['express_attr'] = '文件';
            }else{
                $xlsData[$key]['express_attr'] = '包裹';
            }
        }
        $fileName = $xlsName. $params['params']['task_id'];

        $res = $excel->exportExcel($fileName, $xlsName, $xlsCell, $xlsData);
        $data['id'] = $params['params']['task_id'];
        if($res && $params) {
            $data['file_url'] = $res;
            $data['status'] = 1;
            //写入操作日志
            write_log(L('DATA_EXPORT')."ExpressCompany".L('SUCCESS'));
        }else{
            $data['status'] = 0;
            
            //写入操作日志            
            write_log(L('DATA_EXPORT')."ExpressCompany".L('FAILURE').":".L('CREATE_EXCEL_FAILURE'));
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
        $this->ExpressCompanyModel->startTrans();
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
                    if($data['express_type'] == '国际'){
                        $data['express_type'] = 1;
                    }else{
                        $data['express_type'] = 0;
                    }
                    if($data['express_attr'] == '包裹'){
                        $data['express_attr'] = 1;
                    }else{
                        $data['express_attr'] = 0;
                    }
                    //检验数据是否重复存在
                    $find = M($params['controller'])->where($data)->find();
        
                    if (!$find) {
                        // print_r($data);
                        //重新建数组并合并的原因是下面的time影响上面的find
                        $data2['create_time'] = time();
                        $data2['update_time'] = time();
                        $data3 = array_merge($data,$data2);
                        if(!(M($params['controller'])->add($data3))){
                            $this->ExpressCompanyModel->rollback();
                            $map['status'] = 0; 
                            $params['params']['error_reson'] = L("THE").$i.L("ROW").L("FORMAT_ERROR");

                            break;
                        }
                    }

                }
            }
        }
        $this->ExpressCompanyModel->commit();
        if($map['status'] == 0){
            $map['params'] = serialize($params);
            //写入操作日志            
            write_log(L('DATA_IMPORT')."ExpressCompany".L('FAILURE').":".$params['params']['error_reson']);
        }else{   
            //写入操作日志
            write_log(L('DATA_IMPORT')."ExpressCompany".L('SUCCESS'));
        }
        if(M('Queue')->save($map)){
            return true;
        }
    }

    /**
     * 得到每个表允许导入导出的列名，及导入时需要验证的正则
     *
     * @author luchaonan 2017/03/03
     */
    public function get_list_name(){
        $xlsCell  = array(
            array('express_name','名称'),
            array('express_code','代码'),
            array('express_type','类型'),
            array('express_attr','属性'),
        );
        return $xlsCell;
    }
}