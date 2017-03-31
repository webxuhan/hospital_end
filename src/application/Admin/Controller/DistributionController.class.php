<?php
  namespace Admin\Controller;
  use Common\Controller\AdminbaseController;
  // use Think\Controller;
  class DistributionController extends AdminbaseController {
    protected $distribution_model;
    protected $begin;
    protected $end;
    protected $num;
    // protected $targets=array("_blank"=>"新标签页打开","_self"=>"本窗口打开");
    public function _initialize() {
      parent::_initialize();
      $this->distribution_model = D("Common/Paths");
      $this->begin = '0000000000';
      $this->end   = 'ZZZZZZZZZZ';
      $this->num   =  10;
    }
    /**
    * function index
    * 配送路径的数据展示页面,包含搜索框
    * @author wuzhipeng 2016/01/11
    */
    public function index(){

      //读取座位号配置
      $pre = array('b_pre'=>get_building_prefix(),'f_pre'=>get_floor_prefix(),
                   'a_pre'=>get_area_prefix(),'s_pre'=>get_seat_prefix());
      $this->assign("pre", $pre);

      $where = array("disabled"=>"0");
      //搜索条件
      $path_name = trim(I('request.path_name'));
      $area = strtoupper(trim(I('request.area')));
      $building = strtoupper(trim(I('request.building')));
      $floor = strtoupper(trim(I('request.floor')));
      $seat = strtoupper(trim(I('request.seat')));
      //路径名称的搜索
      if($path_name){
  			$where['path_name'] = array('like',"%$path_name%");
      }

      //path_search
      $az = array('A'=>'1','B'=>'2','C'=>'3','D'=>'4','E'=>'5','F'=>'6',
                  'G'=>'7','H'=>'8','I'=>'9','G'=>'10','K'=>'11','L'=>'12',
                  'M'=>'13','N'=>'14','O'=>'15','P'=>'16','Q'=>'17','R'=>'18',
                  'S'=>'19','T'=>'20','U'=>'21','V'=>'22','W'=>'23','X'=>'24','Y'=>'25','Z'=>'26',);
                  // var_dump(ord('Z1'));65-90
                  //var_dump(ord('01'));48-57
       //路径的搜索
        if ($building) {

          if (get_building_config()=='numeric') {
            //纯数字
            $b = str_pad($building,$this->num,"0",STR_PAD_LEFT);
          }
          if (get_building_config()=="letter") {
            //首字符为字母
            $b0 = substr($building,0,1);
            $b1 = substr($building,1);
            $b = $b0.str_pad($b1,$this->num-1,"0",STR_PAD_LEFT);
          }
          if ($floor) {
            if (get_floor_config()=='numeric') {
              //纯数字
              $f = 10000+$floor*100;

            }
            if (!is_numeric($floor) && ord($floor)>=48 && ord($floor)<=57) {
              //含字母，首字符为数字(夹层)
              $zimu = substr($floor,-1);
              $shuzi = substr($floor,0,-1);
              $f1 = 10000+$shuzi*100+$az[$zimu];
              $f = str_pad($f1,$this->num,"0",STR_PAD_LEFT);
              $f_end = substr($f,0,-2).'99';
            }
            if (ord($floor)==66) {
              //首字符为字母(B1,B2)
              $n = substr($floor,1);
              $f1 = 10000+100-$n;
              $ff = 100-$n;
              $fff = "$ff";
              $f = str_pad($f1,$this->num,"0",STR_PAD_LEFT);
              $f_end = substr($f,0,-2).$fff;
            }

            if ($area) {
              if (get_area_config()=='numeric') {
                //纯数字
                $a = str_pad($area,$this->num,"0",STR_PAD_LEFT);
              }
              if(get_area_config()=='letter'){
                //纯字母
                $a = str_pad($area,$this->num,"0",STR_PAD_RIGHT);
              }

              if ($seat) {
                if (get_seat_config()=='numeric') {
                  //纯数字
                  $s = str_pad($seat,$this->num,"0",STR_PAD_LEFT);
                }
                $search_path = $b.$f.$a.$s;
                $where['search_start'] = array('elt',$search_path);
                $where['search_end'] = array('egt',$search_path);
              }else{
                //填了BFA
                $s1 = $this->begin;
                $s2 = $this->end;
                $search_path1 = $b.$f.$a.$s1;
                $search_path2 = $b.$f.$a.$s2;
                $where['_string'] = "(search_start BETWEEN '{$search_path1}' AND '{$search_path2}')
                                  OR ( search_end BETWEEN '{$search_path1}' AND '{$search_path2}')
                                  OR ( search_end >= '{$search_path2}' AND search_start <= '{$search_path1}')";
              }
            }else{
                //填了BF
                $a1 = $this->begin;
                $a2 = $this->end;
                $s1 = $this->begin;
                $s2 = $this->end;
                $search_path1 = $b.$f.$a1.$s1;
                $search_path2 = $b.$f_end.$a2.$s2;
                $where['_string'] = "(search_start BETWEEN '{$search_path1}' AND '{$search_path2}')
                                  OR ( search_end BETWEEN '{$search_path1}' AND '{$search_path2}')
                                  OR ( search_end >= '{$search_path2}' AND search_start <= '{$search_path1}')";
            }
          }else{
              //只填了B
              $f1 = $this->begin;
              $f2 = $this->end;
              $a1 = $this->begin;
              $a2 = $this->end;
              $s1 = $this->begin;
              $s2 = $this->end;
              $search_path1 = $b.$f1.$a1.$s1;
              $search_path2 = $b.$f2.$a2.$s2;
              $where['_string'] = "(search_start BETWEEN '{$search_path1}' AND '{$search_path2}')
                                OR ( search_end BETWEEN '{$search_path1}' AND '{$search_path2}')
                                OR ( search_end >= '{$search_path2}' AND search_start <= '{$search_path1}')";
              // $where['_string'] = "(search_start >= $search_path1 AND search_start <= $search_path2)  OR ( search_end >= $search_path1 AND search_end <= $search_path2)";
          }
        }
        // print_r($search_path1);
        // print_r($where);

      //分页
      $count=$this->distribution_model->where($where)->count();
      $page = $this->page($count, 10);
      $this->assign("page", $page->show('Admin'));
      $sel = $this->distribution_model
                   ->field('path_id,path_name,building_start,building_end,floor_start,floor_end,
                            area_start,area_end,seat_start,seat_end,disabled,create_time,update_time')
                   ->where($where)
                   ->limit($page->firstRow , $page->listRows)
                   ->order(array("path_id" => "ASC"))
                   ->select();
      //整合路径数据，转换时间格式
      foreach ($sel as $k => $v) {
         $v['path_detail'] = $v['building_start']."-".$v['floor_start']."-".$v['area_start']."-".$v['seat_start']." ~ ".
                               $v['building_end']."-".$v['floor_end']."-".$v['area_end']."-".$v['seat_end'];

         $data[$k]['path_id']  = $v['path_id'];
         $data[$k]['path_name']  = $v['path_name'];
         $data[$k]['path_detail'] = $v['path_detail'];
         $data[$k]['create_time']  = date("Y/m/d H:i",$v['create_time']);
         $data[$k]['update_time']  = date("Y/m/d H:i",$v['update_time']);
      }
      // print_r($where);
      $res = $this->distribution_model->where($where)->count();
      if ($res!=0) {
        $this -> assign('data',$data);
      }
      $this -> display();
    }
    /**
    * function add
    * 添加配送路径的展示页面
    * @author wuzhipeng 2016/01/11
    */
    public function add() {
      //读取座位号配置
      $pre = array('b_pre'=>get_building_prefix(),'f_pre'=>get_floor_prefix(),
                   'a_pre'=>get_area_prefix(),'s_pre'=>get_seat_prefix());
      $this->assign("pre", $pre);
      $this->display();
    }

    /**
    * function add_post
    * 添加配送路径,保存字母的大写形式,增加创建时间以及更新时间
    * @author wuzhipeng 2016/01/11
    */
    public function add_post() {
      if (IS_POST) {
        foreach ($_POST as $k => $v) {
          //拼接search_start,search_end
          $arr_start = array('building_start','floor_start','area_start','seat_start');
          $arr_end = array('building_end','floor_end','area_end','seat_end');
          //字母大写
          $p[$k] = strtoupper($v);
        }
        $p['path_name'] = $_POST['path_name'];
        $p['create_time'] = time();
        $p['update_time'] = time();

        $az = array('A'=>'1','B'=>'2','C'=>'3','D'=>'4','E'=>'5','F'=>'6',
                    'G'=>'7','H'=>'8','I'=>'9','G'=>'10','K'=>'11','L'=>'12',
                    'M'=>'13','N'=>'14','O'=>'15','P'=>'16','Q'=>'17','R'=>'18',
                    'S'=>'19','T'=>'20','U'=>'21','V'=>'22','W'=>'23','X'=>'24','Y'=>'25','Z'=>'26',);
        //building
        if (get_building_config()=="letter") {
          $b11 = substr($p['building_start'],0,1);
          $b12 = substr($p['building_start'],1);
          $b_s = $b11.str_pad($b12,$this->num-1,"0",STR_PAD_LEFT);
          $b21 = substr($p['building_end'],0,1);
          $b22 = substr($p['building_end'],1);
          $b_e = $b21.str_pad($b22,$this->num-1,"0",STR_PAD_LEFT);
        }else{
          $b_s = str_pad($p['building_start'],$this->num,"0",STR_PAD_LEFT);
          $b_s = str_pad($p['building_end'],$this->num,"0",STR_PAD_LEFT);
        }

        //floor
        if (get_floor_config()=='numeric') {
          //纯数字
          $f_s = str_pad($p['floor_start'],$this->num,"0",STR_PAD_LEFT);
          $f_e = str_pad($p['floor_end'],$this->num,"0",STR_PAD_LEFT);
        }
        if (!is_numeric($p['floor_start']) && ord($p['floor_start'])>=48 && ord($p['floor_start'])<=57) {
          //含字母，首字符为数字(夹层)
          $zimu = substr($p['floor_start'],-1);
          $shuzi = substr($p['floor_start'],0,-1);
          $f1 = 10000+$shuzi*100+$az[$zimu];
          $f_s = str_pad($f1,$this->num,"0",STR_PAD_LEFT);
        }
        if (ord($p['floor_start'])==66) {
          //首字符为字母(B1,B2)
          $n = substr($p['floor_start'],1);
          $f1 = 10000+100-$n;
          $f_s = str_pad($f1,$this->num,"0",STR_PAD_LEFT);
        }
        if (!is_numeric($p['floor_end']) && ord($p['floor_end'])>=48 && ord($p['floor_end'])<=57) {
          //含字母，首字符为数字(夹层)
          $zimu = substr($p['floor_end'],-1);
          $shuzi = substr($p['floor_end'],0,-1);
          $f1 = 10000+$shuzi*100+$az[$zimu];
          $f_e = str_pad($f1,$this->num,"0",STR_PAD_LEFT);
        }
        if (ord($p['floor_end'])==66) {
          //首字符为字母(B1,B2)
          $n = substr($p['floor_end'],1);
          $f1 = 10000+100-$n;
          $f_e = str_pad($f1,$this->num,"0",STR_PAD_LEFT);
        }
        //area
        if (get_area_config()=='letter') {
          $a_s = str_pad($p['area_start'],$this->num,"0",STR_PAD_RIGHT);
          $a_e = str_pad($p['area_end'],$this->num,"0",STR_PAD_RIGHT);
        }else{
          $a_s = str_pad($p['area_start'],$this->num,"0",STR_PAD_LEFT);
          $a_e = str_pad($p['area_end'],$this->num,"0",STR_PAD_LEFT);
        }
        //seat
        if (get_seat_config()=='numeric') {
          //纯数字
          $s_s = str_pad($p['seat_start'],$this->num,"0",STR_PAD_LEFT);
          $s_e = str_pad($p['seat_end'],$this->num,"0",STR_PAD_LEFT);
        }
        $p['search_start'] = $b_s.$f_s.$a_s.$s_s;
        $p['search_end'] = $b_e.$f_e.$a_e.$s_e;

        if ($this->distribution_model->create($p)!==false) {
          if ($this->distribution_model->add()!==false) {
            $this->success(L('ADD_SUCCESS'), U('Distribution/add'));
          } else {
            $this->error(L('ADD_FAILED'));
          }
        } else {
          $this->error($this->distribution_model->getError());
        }
      }
    }

    // 后台菜单删除
    public function delete() {
      if(isset($_POST['ids'])){
        $ids = I('post.ids/a');
        if ($this->distribution_model->where(array('path_id'=>array('in',$ids)))->save(array('disabled'=>1))!==false) {
          $this->success(L('DELETE_SUCCESS'));
        } else {
          $this->error(L('DELETE_FAILURE'));
        }
      }else{
        $id = I("get.id",0,'intval');
        if ($this->distribution_model->where(array('path_id'=>$id))->save(array('disabled'=>1))!==false) {
          $this->success(L('DELETE_SUCCESS'));
        } else {
          $this->error(L('DELETE_FAILURE'));
        }
      }
    }

    /**
    * function edit
    * 编辑配送路径的显示页面s
    * @author wuzhipeng 2016/01/11
    */
    public function edit() {
        $distribution_id = I("get.id",0,'intval');
        $rs = $this->distribution_model->where(array("path_id" => $distribution_id))->find();
        // print_r($rs);die;
        $this->assign("data", $rs);
        //读取座位号配置
        $pre = array('b_pre'=>get_building_prefix(),'f_pre'=>get_floor_prefix(),
                     'a_pre'=>get_area_prefix(),'s_pre'=>get_seat_prefix());
        $this->assign("pre", $pre);
        $this->display();
    }
    /**
    * function edit_post
    * 编辑配送路径,保存字母的大写形式,更新时间
    * @author wuzhipeng 2016/01/11
    */
    public function edit_post() {
      if (IS_POST) {
        // print_r($_POST);die;
          $id = I('post.path_id',0,'intval');
          $p=$this->distribution_model->where(array('path_id'=>$id))->find();
          $p['search_start'] = '';
          $p['search_end'] = '';
          foreach ($_POST as $k => $v) {
            //字母大写
            $p[$k] = strtoupper($v);
            //拼接search_start,search_end
            //新建变量$arr_start为了过滤path_id与其他不要的字段
            $arr_start = array('building_start','floor_start','area_start','seat_start');
            $arr_end = array('building_end','floor_end','area_end','seat_end');
            if (in_array($k,$arr_start)) {
              $p['search_start'] .= str_pad($v,10,"0",STR_PAD_LEFT);
            }
            if (in_array($k,$arr_end)) {
              $p['search_end'] .= str_pad($v,10,"0",STR_PAD_LEFT);
            }
          }
          $p['path_name'] = $_POST['path_name'];
          $p['update_time'] = time();
          $az = array('A'=>'1','B'=>'2','C'=>'3','D'=>'4','E'=>'5','F'=>'6',
                      'G'=>'7','H'=>'8','I'=>'9','G'=>'10','K'=>'11','L'=>'12',
                      'M'=>'13','N'=>'14','O'=>'15','P'=>'16','Q'=>'17','R'=>'18',
                      'S'=>'19','T'=>'20','U'=>'21','V'=>'22','W'=>'23','X'=>'24','Y'=>'25','Z'=>'26',);
          //building
          if (get_building_config()=="letter") {
            $b11 = substr($p['building_start'],0,1);
            $b12 = substr($p['building_start'],1);
            $b_s = $b11.str_pad($b12,$this->num-1,"0",STR_PAD_LEFT);
            $b21 = substr($p['building_end'],0,1);
            $b22 = substr($p['building_end'],1);
            $b_e = $b21.str_pad($b22,$this->num-1,"0",STR_PAD_LEFT);
          }else{
            $b_s = str_pad($p['building_start'],$this->num,"0",STR_PAD_LEFT);
            $b_s = str_pad($p['building_end'],$this->num,"0",STR_PAD_LEFT);
          }

          //floor
          if (get_floor_config()=='numeric') {
            //纯数字
            $f_s = str_pad($p['floor_start'],$this->num,"0",STR_PAD_LEFT);
            $f_e = str_pad($p['floor_end'],$this->num,"0",STR_PAD_LEFT);
          }
          if (!is_numeric($p['floor_start']) && ord($p['floor_start'])>=48 && ord($p['floor_start'])<=57) {
            //含字母，首字符为数字(夹层)
            $zimu = substr($p['floor_start'],-1);
            $shuzi = substr($p['floor_start'],0,-1);
            $f1 = 10000+$shuzi*100+$az[$zimu];
            $f_s = str_pad($f1,$this->num,"0",STR_PAD_LEFT);
          }
          if (ord($p['floor_start'])==66) {
            //首字符为字母(B1,B2)
            $n = substr($p['floor_start'],1);
            $f1 = 10000+100-$n;
            $f_s = str_pad($f1,$this->num,"0",STR_PAD_LEFT);
          }
          if (!is_numeric($p['floor_end']) && ord($p['floor_end'])>=48 && ord($p['floor_end'])<=57) {
            //含字母，首字符为数字(夹层)
            $zimu = substr($p['floor_end'],-1);
            $shuzi = substr($p['floor_end'],0,-1);
            $f1 = 10000+$shuzi*100+$az[$zimu];
            $f_e = str_pad($f1,$this->num,"0",STR_PAD_LEFT);
          }
          if (ord($p['floor_end'])==66) {
            //首字符为字母(B1,B2)
            $n = substr($p['floor_end'],1);
            $f1 = 10000+100-$n;
            $f_e = str_pad($f1,$this->num,"0",STR_PAD_LEFT);
          }
          //area
          if (get_area_config()=='letter') {
            $a_s = str_pad($p['area_start'],$this->num,"0",STR_PAD_RIGHT);
            $a_e = str_pad($p['area_end'],$this->num,"0",STR_PAD_RIGHT);
          }else{
            $a_s = str_pad($p['area_start'],$this->num,"0",STR_PAD_LEFT);
            $a_e = str_pad($p['area_end'],$this->num,"0",STR_PAD_LEFT);
          }
          //seat
          if (get_seat_config()=='numeric') {
            //纯数字
            $s_s = str_pad($p['seat_start'],$this->num,"0",STR_PAD_LEFT);
            $s_e = str_pad($p['seat_end'],$this->num,"0",STR_PAD_LEFT);
          }
          $p['search_start'] = $b_s.$f_s.$a_s.$s_s;
          $p['search_end'] = $b_e.$f_e.$a_e.$s_e;
        if ($this->distribution_model->create($p)!==false) {
          if ($this->distribution_model->save() !== false) {
            $this->success(L('EDIT_SUCCESS'), U('Distribution/index'));
          } else {
            $this->error(L('EDIT_FAILED'));
          }
        } else {
          $this->error($this->menu_model->getError());
        }
      }
    }

      /**
       * 座位号页面显示
       *
       * @author Face 2017/01/12
       */
      public function seat_prefix() {
          $params = S('mailroom_seat_no_prefix');
          $this->assign('building_prefix', $params['building_prefix']);
          $this->assign('floor_prefix', $params['floor_prefix']);
          $this->assign('area_prefix', $params['area_prefix']);
          $this->assign('seat_prefix', $params['seat_prefix']);

          $seat_number_rule = S('seat_number_rule');
          if(!$seat_number_rule || count($seat_number_rule) <= 0) {
              $seat_number_rule = array(
                  'building_configuration' => 'numeric',
                  'floor_configuration' => 'numeric',
                  'area_configuration' => 'numeric',
                  'seat_configuration' => 'numeric',
              );
          }
          $this->assign('building_configuration', $seat_number_rule['building_configuration']);
          $this->assign('floor_configuration', $seat_number_rule['floor_configuration']);
          $this->assign('area_configuration', $seat_number_rule['area_configuration']);
          $this->assign('seat_configuration', $seat_number_rule['seat_configuration']);
          $this->display();
      }

      /**
       * 座位号前前缀保存
       *
       * @author Face 2017/01/12
       */
      public function seat_prefix_post() {
          $params = I('param.');
          $mailroom_seat_no_prefix['building_prefix']   = strtoupper($params['building_prefix']);
          $mailroom_seat_no_prefix['floor_prefix']       = strtoupper($params['floor_prefix']);
          $mailroom_seat_no_prefix['area_prefix']        = strtoupper($params['area_prefix']);
          $mailroom_seat_no_prefix['seat_prefix']        = strtoupper($params['seat_prefix']);

          if(!$this->seat_number_already_exists()) {

              $seat_number_rule['building_configuration']   = $params['building_configuration'];
              $seat_number_rule['floor_configuration']      = $params['floor_configuration'];
              $seat_number_rule['area_configuration']       = $params['area_configuration'];
              $seat_number_rule['seat_configuration']       = $params['seat_configuration'];
              S('seat_number_rule', $seat_number_rule);
          }


          S('mailroom_seat_no_prefix', $mailroom_seat_no_prefix);
          $this->success(L('EDIT_SUCCESS'));
      }

      /**
       * check seat no. already exists
       * 没有项目奖金，不想写代码
       * @return bool
       *
       * @author Face 2017/01/19
       */
      private function seat_number_already_exists() {
          $where = array(
              'building' => array('neq', 0),
              'floor_no' => array('neq', 0),
              'area_no'  => array('neq', 0),
              'seat_no'  => array('neq', 0),
              '_logic'   => 'or',
          );
          $info = M('Staff')->where($where)->field('staff_id')->find();
          return $info['staff_id'] ? true : false;
      }
}
