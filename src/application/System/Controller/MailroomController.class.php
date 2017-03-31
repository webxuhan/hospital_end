<?php
namespace System\Controller;

use Think\Controller;
use Common\Controller\ExcelController;
  // use Think\Controller;
  class MailroomController extends Controller {
    private $mailroom_model;
    public function _initialize() {
      $this->mailroom_model = D("Common/mailroom");
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
          $fileName = $xlsName. $params['params']['task_id'];

          $res = $excel->exportExcel($fileName, $xlsName, $xlsCell, $xlsData);
          $data['id'] = $params['params']['task_id'];
          if($res && $params) {
              $data['file_url'] = $res;
              $data['status'] = 1;
              //写入操作日志
              write_log(L('DATA_EXPORT')."Mailroom".L('SUCCESS'));
          }else{
              $data['status'] = 0;
              
              //写入操作日志            
              write_log(L('DATA_EXPORT')."Mailroom".L('FAILURE').":".L('CREATE_EXCEL_FAILURE'));
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
          $this->mailroom_model->startTrans();
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

                      //检验数据是否重复存在
                      $find = M($params['controller'])->where($data)->find();
          
                      if (!$find) {
                          // print_r($data);
                          //重新建数组并合并的原因是下面的time影响上面的find
                          $data2['create_time'] = time();
                          $data2['update_time'] = time();
                          $data3 = array_merge($data,$data2);
                          if(!(M($params['controller'])->add($data3))){
                              $this->mailroom_model->rollback();
                              $map['status'] = 0; 
                              $params['params']['error_reson'] = L("THE").$i.L("ROW").L("FORMAT_ERROR");

                              break;
                          }
                      }

                  }
              }
          }
          $this->mailroom_model->commit();
          if($map['status'] == 0){
              $map['params'] = serialize($params);
              //写入操作日志            
              write_log(L('DATA_IMPORT')."Mailroom".L('FAILURE').":".$params['params']['error_reson']);
          }else{   
              //写入操作日志
              write_log(L('DATA_IMPORT')."Mailroom".L('SUCCESS'));
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
              array('mailroom_name','名称'),
              array('contacts','联系人'),
              array('mobile','手机'),
              array('tel','电话'),
              array('city','所属城市'),
              array('customer','所属客户'),
              array('address','详细地址'),
          );
          return $xlsCell;
      }

}
