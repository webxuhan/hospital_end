<?php
  namespace Admin\Controller;
  use Common\Controller\AdminbaseController;
  // use Think\Controller;
  class WayController extends AdminbaseController {
    protected $Way_model;

    private $params;

    public function _initialize() {
       parent::_initialize();
       $this->Way_model = D('Way');
       $this->params = I('params.');
    }
    /**
    * function index
    * 配送路径的数据展示页面,包含搜索框
    * @author wuzhipeng 2017/01/11
    */
    public function index(){

        //搜索条件

        $where = array("cmf_way.disabled"=>"0");
        //搜索条件
        $way_name = trim(I('request.way_name'));
        $seat_detail = trim(I('request.seat_detail'));
        if($way_name != ''){
            $where['way_name'] = get_search_str($way_name);
        }
        if($seat_detail != ''){
            $where['seat_detail'] = get_search_str($seat_detail);
        }

       //分页
        $count=$this->Way_model->where($where)->count();
        $page = $this->page($count, 10);
        $this->assign("page", $page->show('Admin'));
        $sel = $this->Way_model->field('cmf_way.way_id,cmf_way.way_name,cmf_way.enabled,cmf_way.create_time,cmf_way.update_time')
                     ->join('cmf_way_seat ON cmf_way.way_id = cmf_way_seat.way_id','LEFT')
                     ->join('cmf_seat ON cmf_seat.seat_id = cmf_way_seat.seat_id','LEFT')
                     ->limit($page->firstRow , $page->listRows)
                     ->where($where)
                     ->group('cmf_way.way_name')
                     ->order(array("way_id" => "ASC"))
                     ->select();
//        print_r($sel);die;
//        print_r($this->Way_model->getLastSql());die;
       //整合路径数据，转换时间格式
        $Send_way = M("Send_way");
       foreach ($sel as $k => $v) {
           $data[$k]['way_id']  = $v['way_id'];
           $data[$k]['way_name']  = $v['way_name'];
           $data[$k]['enabled']  = $v['enabled'];
           if($v['enabled']==1){
               $data[$k]['status'] = L('ENABLED');
               $data[$k]['action'] = L('DISABLED');
           }else{
               $data[$k]['status'] = L('DISABLED');
               $data[$k]['action'] = L('ENABLED');
           }

           $data[$k]['create_time']  = date("Y/m/d H:i",$v['create_time']);
           $data[$k]['update_time']  = date("Y/m/d H:i",$v['update_time']);

           //查询是否存在路径已经被计划选用
           $re = $Send_way->where(array('way_id'=>$v['way_id']))->find();
           if($re){
               $data[$k]['del_status'] = 1;
           }else{
               $data[$k]['del_status'] = 0;
           }
       }
//        print_r($data);die;
       $res = $this->Way_model->count();
       if ($res!=0) {
         $this -> assign('data',$data);
       }



      $this -> display();
    }

      /**
       * function check
       * 查看路径包含的座位号
       * @author wuzhipeng 2017/02/12
       */
      public function check() {
          $Way_seat = M("Way_seat");
          $Seat = M("Seat");
          $Way_id = I("get.id",0,'intval');
//          print_r($Way_id);die;
          $rs = $Way_seat->field('way_id,seat_id')
                        ->where(array("way_id" => $Way_id,))
                        ->select();
          $seat_str = '';
          foreach ($rs as $v) {
             $seat_str .= $v['seat_id'].',';

          }

          $seat_id = rtrim($seat_str);
//          print_r($rs);die;
          $where['seat_id'] = array('in',$seat_id);
//          print_r($seat_id);die;
          $sel = $Seat->field('seat_id,seat_detail')
                      ->where($where)
                      ->order(array("seat_id" => "ASC"))
                      ->select();
//          print_r($sel);die;
          $this->assign("seat", $sel);
//          print_r($sel);die;
          $this->display();
      }


      /**
       * function enable
       * 开启派送路径
       * @author wuzhipeng 2017/02/12
       */
      public function enable() {
          $Way_id = I("get.id",0,'intval');
          //判断此时是要启用还是禁用
          $bool = $this->Way_model->where(array('enabled'=>1,'way_id'=>$Way_id))->find();

          $Send_way = M('Send_way');
          $Send_way->startTrans();
          if ($bool){
              //启用中,此时要禁用
              if ($this->Way_model->where(array('way_id'=>$Way_id))->save(array('enabled'=>0))!==false) {
                  //disabled掉send_way里的此way_id
                  $ways = $Send_way->field('id')->where(array('way_id'=>$Way_id))->select();
                  foreach($ways as $v){
                      $ss = $Send_way->where(array('id'=>$v['id']))->save(array('disabled'=>1));
                      if(!$ss){
                          $Send_way->rollback();
                          $this->error(L('ENABLE_FAILURE'));
                      }
                  }
                  $Send_way->commit();
                  clear_way_list();
                  $this->success(L('ENABLE_SUCCESS'));
              } else {
                  $Send_way->rollback();
                  $this->error(L('ENABLE_FAILURE'));
              }
          }else{
              //要启用

              //启用之前先判断已经启用的路径中是否已经包含了本次要启用路径的座位号，如果包含，不允许启用
              $Way_seat = M("Way_seat");
              $where['cmf_way.enabled'] = 1;
              $where['cmf_way.disabled'] = 0;
              $sel = $Way_seat ->field('cmf_way_seat.way_id,cmf_way_seat.seat_id')
                  ->join('cmf_way ON cmf_way.way_id = cmf_way_seat.way_id')
                  ->where($where)
                  ->order(array("seat_id" => "ASC"))
                  ->select();
//          print_r($sel);die;
              foreach($sel as $v){
                  $seat_arr[] = $v['seat_id'];
              }
//          print_r($seat_arr);die;
              $res = $Way_seat
                  ->field('seat_id')
                  ->where(array('way_id'=>$Way_id,'disabled'=>0))
                  ->order(array("seat_id" => "ASC"))
                  ->select();
//          print_r($res);die;

              //如果路径为空（所有包含的座位号被删掉后），不允许启用

              if(!$res){
                  $Send_way->rollback();
                  $this->error(L('ENABLE_EMPTY'));
              }

              foreach($res as $v){
                  $seat_enabled_arr[] = $v['seat_id'];
              }

              $merge_arr = array_merge($seat_arr,$seat_enabled_arr );

              if (count($merge_arr) == count(array_unique($merge_arr))){

                  if ($this->Way_model->save(array('enabled'=>1,'way_id'=>$Way_id))!==false) {

                      //如果有计划用了这个路径，恢复send_way里的此way_id的disabled
                      $w = $Send_way->where(array('way_id'=>$Way_id))->find();

                      if($w){
                          $ways = $Send_way->field('id')->where(array('way_id'=>$Way_id))->select();
                          foreach($ways as $v){
                              $ss = $Send_way->where(array('id'=>$v['id']))->save(array('disabled'=>0));
                              if(!$ss){
                                  $Send_way->rollback();
                                  $this->error(L('ENABLE_FAILURE'));
                              }
                          }
                      }

                      $Send_way->commit();
                      clear_way_list();
                      $this->success(L('ENABLE_SUCCESS'));
                  } else {
                      $Send_way->rollback();
                      $this->error(L('ENABLE_FAILURE'));
                  }
              }else{
                  $Send_way->rollback();
                  $this->error(L('ENABLE_FAILURE_HAS'));
              }
          }


      }

    /**
    * function add
    * 添加配送路径的展示页面
    * @author wuzhipeng 2017/02/10
    */
    public function add() {
      //读取座位号数据
      if(IS_POST){
          $where['disabled'] = 0;
          if (IS_POST) {
//               print_r($_POST);die;
              $s = trim(I('post.seat_detail'));
              $seat_id = explode(",",rtrim(I('post.seat_id'), ","));
              if ($s) {
                  $where['seat_detail'] = get_search_str($s);
              }
              if ($seat_id) {
                  // $where['_string'] = "(seat_id NOT IN ({$seat_id}))";
                  $where['seat_id'] = array('not in',$seat_id);
              }
              // print_r($where);
          }

          $seat = M("Seat");
          $sel = $seat
              ->field('seat_id,seat_detail,disabled')
              ->where($where)
              ->order(array("seat_id" => "ASC"))
              ->select();
//            print_r($sel);die;
          $this->assign("seat", $sel);
          if ($where !== 1) {
              $this->ajaxReturn($sel);
          }
          // $this->ajaxReturn($sel);
          // print_r($sel);die;
      }

      $this->display();

    }

    /**
    * function add_post
    * 添加配送路径,增加创建时间以及更新时间
    * @author wuzhipeng 2017/02/10
    */
    public function add_post() {
        $post = I('post.');
//         print_r($post);die;
          if (!empty($post['way_name'])) {

                  $Way_seat = M("Way_seat");

                  $p['way_name'] = $post['way_name'];

                  $time = time();

                  $p['create_time'] = $time;
                  $p['update_time'] = $time;


                  $find = $this->Way_model->where(array('way_name'=>$p['way_name'],'disabled'=>0))->find();
                  if ($find) {
                      $this->error(L('THE_SAME_EXIT'));
                  }

                  $this->Way_model->startTrans();
                  if ($this->Way_model->create($p)!==false){
                      $res1 = $this->Way_model->add();
                      if($res1){

                          if (!empty($post['seat_id'])) {
                              $s_arr = explode(",",rtrim($post['seat_id'], ","));
                              $way_id = $res1;
                              foreach ($s_arr as $k => $v) {
                                  $s[$k]['seat_id'] = $v;
                                  $s[$k]['way_id'] = $way_id;
                                  $s[$k]['create_time'] = $p['create_time'];
                                  $s[$k]['update_time'] = $p['update_time'];
                              }
                              $res2 = $Way_seat->addAll($s);

                              if ($res2) {
                                  $this->Way_model->commit();
                                  $this->success(L('ADD_SUCCESS'), U('Way/add'));
                              }else{
                                  $this->Way_model->rollback();
                                  $this->error(L('ADD_FAILED'));
                              }
                          }else{
                              $this->Way_model->commit();
                              $this->success(L('ADD_SUCCESS'), U('Way/add'));
                          }

                      }else{
                          $this->Way_model->rollback();
                          $this->error(L('ADD_FAILED'));
                      }
                  }else {
                          $this->Way_model->rollback();
                          $this->error($this->Way_model->getError());
                  }


          }
      }
    // 后台菜单删除
    public function delete() {
        $Send_way = M("Send_way");
        if(isset($_POST['ids'])){
            $ids = I('post.ids/a');

            //查询是否存在路径已经被计划选用
            $re = $Send_way->where(array('way_id'=>array('in',$ids)))->select();
            if($re){
                $this->error(L('DELETE_F'));
            }

            $Send_way->startTrans();
            //删除计划里的对应路径
            $sel_send_way = $Send_way->where(array('way_id'=>array('in',$ids)))->delete();
            if($sel_send_way === false){
                $Send_way->rollback();
                $this->error(L('DELETE_FAILURE'));
            }

            //逻辑删除路径
            if ($this->Way_model->where(array('way_id'=>array('in',$ids)))->save(array('disabled'=>1))!==false) {
                $Send_way->commit();
                $this->success(L('DELETE_SUCCESS'));
            } else {
                $Send_way->rollback();
                $this->error(L('DELETE_FAILURE'));
            }
        }else{
            $id = I("get.id",0,'intval');



            $Send_way->startTrans();

            //删除计划里的对应路径
            $sel_way_seat = $Send_way->where(array('way_id'=>$id))->delete();
            if($sel_way_seat === false){
                $Send_way->rollback();
                $this->error(L('DELETE_FAILURE'));
            }

            //逻辑删除路径
            if ($this->Way_model->where(array('way_id'=>$id))->save(array('disabled'=>1))!==false) {
                $Send_way->commit();
                $this->success(L('DELETE_SUCCESS'));
            } else {
                $Send_way->rollback();
                $this->error(L('DELETE_FAILURE'));
            }
        }


    }

    /**
    * function edit
    * 编辑配送路径的显示页面s
    * @author wuzhipeng 2017/02/11
    */
    public function edit() {
        $Way_id = I("get.id",0,'intval');
        $where['cmf_way.way_id'] = $Way_id;
        $Seat = M("Seat");
        $Way_seat = M("Way_seat");
        //右边路径座位号与路径名称的显示
        $rs = $this->Way_model->field('cmf_way.way_id,cmf_way.way_name,cmf_way_seat.seat_id,seat_detail')
                    ->join('cmf_way_seat ON cmf_way.way_id = cmf_way_seat.way_id','LEFT')
                    ->join('cmf_seat ON cmf_seat.seat_id = cmf_way_seat.seat_id','LEFT')
                    ->where($where)
                    ->order(array("way_id" => "ASC"))
                    ->select();
//         print_r($rs);die;

        $way_name = $rs[0]['way_name'];
//        print_r($way_name);die;
        $this->assign("way", $rs);
        $this->assign("way_name", $way_name);
        if (IS_POST){
                //左边座位号要排除路径里的座位号
                foreach($rs as $v){
                    $seat_id_out[] = $v['seat_id'];
                }
//              print_r($seat_id_out);die;
                $str['disabled'] = 0;
                $seat_detail = trim(I('request.seat_detail'));
                $str['seat_detail'] = get_search_str($seat_detail);
//                print_r($str);die;
                $str['seat_id'] = array('not in',$seat_id_out);
                $sel = $Seat->field('seat_id,seat_detail')
                    ->where($str)
                    ->order(array("seat_id" => "ASC"))
                    ->select();
//            print_r($sel);die;
//          print_r($Seat->getLastSql());die;
                $this->assign("seat", $sel);

            }
            //way_id
            $way_id = $rs[0]['way_id'];
            $this->assign("way_id", $way_id);
            //seat_id
            $seat_id = '';
            foreach($rs as $v){
                $seat_id .= $v['seat_id'].',';
            }
//        print_r($seat_id);die;
            $this->assign("seat_id", $seat_id);

        $this->display();
    }
    /**
    * function edit_post
    * 编辑配送路径,更新时间
    * @author wuzhipeng 2017/02/12
    */
    public function edit_post() {
        $post = I('post.');
//         print_r($post);die;
        if (IS_POST) {
//             print_r($_POST);die;
            if (!empty($post['way_name'])) {

                $Way_seat = M("Way_seat");
                $p['way_id'] = $post['way_id'];
                $p['way_name'] = $post['way_name'];

                $time = time();
                $p['create_time'] = $time;
                $p['update_time'] = $time;
                // print_r($p);die;

                $h = $Way_seat->field('id')->where(array('way_id'=>$p['way_id']))->select();

                foreach($h as $v){
                    $h_arr[] = $v['id'];
                }
                    $where['id'] = array('in',$h_arr);



                //检查修改后是否重复添加
                $data['way_id'] = $p['way_id'];
                $data['way_name'] = $p['way_name'];
                $data['disabled'] = 0;
                $id = $data['way_id'];
                unset($data['way_id']);
                $find = $this->Way_model->field('way_id')->where($data)->find();
                if (isset($find['way_id']) && $find['way_id']!=$id) {
                    $this->error(L('THE_SAME_EXIT'));
                }
                //获取启用字段数据
                $e = $this->Way_model->field('enabled')->where($data)->find();
                $p['enabled'] = $e['enabled']?$e['enabled']:0;
                //删掉way_seat，way里对应所有的数据
                $this->Way_model->startTrans();
                //如果路径为空，不需要以下删除
                if($h){
                    $d1 = $Way_seat->where($where)->delete();
                    if(!$d1){
                        $this->Way_model->rollback();
                        $this->error(L('SAVE_FAILED'));
                    }
                }
                $d2 = $this->Way_model->where(array('way_id'=>$p['way_id']))->delete();
                if(!$d2){
                    $this->Way_model->rollback();
                    $this->error(L('SAVE_FAILED'));
                }

                if ($this->Way_model->create($p)!==false){
                    $res1 = $this->Way_model->add();
                    if(!$res1){
                        $this->Way_model->rollback();
                        $this->error(L('SAVE_FAILED'));
                    }
                } else {
                    $this->Way_model->rollback();
                    $this->error($this->Way_model->getError());
                }

                if (!empty($post['seat_id'])) {
                    $s_arr = explode(",",rtrim($post['seat_id'], ","));

                    foreach ($s_arr as $k => $v) {
                        $s[$k]['seat_id'] = $v;
                        $s[$k]['way_id'] = $p['way_id'];
                        $s[$k]['update_time'] = time();
                        $s[$k]['create_time'] = time();
                    }
                    $res2 = $Way_seat->addAll($s);
                    if(!$res2){
                        $this->Way_model->rollback();
                        $this->error(L('SAVE_FAILED'));
                    }else{
                        $this->Way_model->commit();
                        $this->success(L('SAVE_SUCCESS'), U('Way/index'));
                    }
                }

                    $this->Way_model->commit();
                    $this->success(L('SAVE_SUCCESS'), U('Way/index'));

            }
        }
    }

    /**
     * 导入页面
     *
     * @author luchaonan 2017/03/03
     */
    public function import_index(){
        $url = CONTROLLER_NAME."/import_export";
        $this->assign("url",$url);
        $this->display('Import/import');
    }

    /**
     * 导入导出提交，建立队列任务
     *
     * @author luchaonan 2017/03/03
     */
    public function import_export(){
        if(IS_POST){
            $queue_type = I('post.queue_type',1,intval);
            if($queue_type == 2){
                $config=array(
                    'allowExts'=>array('xlsx','xls'),
                    'rootPath' =>  './data/',
                    'savePath'=>'excel/import/',
                    'saveRule'=>'time',
                );
                $upload = new \Think\Upload($config);
                $info = $upload->upload();
                if($info){
                    $params['info'] = $info;
                }else{
                    $this->error($this->error);
                }
            }
            $action = I('post.action');
            $controller = CONTROLLER_NAME;
            //$model = MODULE_NAME;
            $task_name = CONTROLLER_NAME.' '.$action;
            $task_id = add_tasks($controller,$action,$params,$task_name,$queue_type);
            if($task_id){
                if($queue_type == 1){
                    $this->ajaxReturn($queue_type);
                }else{
                    $this->success('已添入导入队列，等待执行！');
                }
            }
        }
        //print_r($_FILES);
    }
}
