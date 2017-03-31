<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2014 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace Portal\Controller;

use Common\Controller\HomebaseController;

class RegionsController extends HomebaseController{

	public function index(){

        $params = S('mailroom_regions_test');
        $this->assign('test1', $params['test1']);
        $this->assign('test2', $params['test2']);
        $this->assign('test3', $params['test3']);
        $this->assign('test4', $params['test4']);
        $this->assign('test5', $params['test5']);
		$this->display();
	}

    public function index_post() {
        $params = I('param.');
        S('mailroom_regions_test', $params);
        $this->success('success');
    }

    public function tree() {
        $data = S('test_region_tree');

        $this->assign('region_tree_1', $data['region_tree_1']);
        $this->assign('region_tree_2', $data['region_tree_2']);
        $this->assign('region_tree',$data['region_tree']);
        $this->display();
    }

    public function tree_post() {
        $params = I('param.');
        S('test_region_tree',$params);
        $this->success('SUCCESS');
    }

    public function test() {

        $a = new \Org\Net\IpLocation();

    }

    function generateTree($items){
        $arr = array();
        foreach($items as $val) {
            $arr[$val['id']] = $val;
        }
        $items = $arr;
        foreach($items as $item)
            $items[$item['parent_id']]['list'][$item['id']] = &$items[$item['id']];
        return isset($items[0]['list']) ? $items[0]['list'] : array();
    }

    function generateTree2($items){
        $tree = array();
        $i = 0;
        foreach($items as $item){
            var_dump(($items[$item['parent_id']]));
            var_dump(isset($items[$item['parent_id']]));
            echo '<br>';
            if(isset($items[$item['parent_id']])){
                $items[$item['parent_id']]['list'][] = &$items[$item['id']];
            }else{
                $tree[] = &$items[$item['id']];
            }
            if($i++ > 10) break;
        }
        return $tree;
    }

    public function out($list) {
        header('Content-type:text/html;charset=utf8;');
        foreach($list as $key => $val) {
            echo 'key:',$key,'----val:';
            var_dump($val);
            echo '<br>';
        }
    }


}