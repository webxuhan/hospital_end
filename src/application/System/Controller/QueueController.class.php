<?php
/**
 * 队列工具
 *
 * @author Face 2017/03/09
 */
namespace System\Controller;

use Think\Controller;

class QueueController extends Controller{

    // 队列model
    private $queue_model;

    public function _initialize() {
        $this->queue_model = M('Queue');
    }

    public function add_task () {
        $args = func_get_args();
        $params = array(
            'controller' => $args[0],//'Admin\Controller\TestController',
            'model' => $args[1],//Admin
            'action' => $args[2],//index
            'params' => $args[3],//array('task_id' => 0,);
        );
        $time = time();
        /* $controller $action $params $task_name $queue_type  */
        $params = serialize($params);
        $data = array(
            'name' => $args[4],
            'params' => $params,
            'create_time' => $time,
            'update_time' => $time,
            'queue_type' => $args[5],
        );
        $id = $this->queue_model->add($data);
        if($id) {
            // TODO 添加成功请稍后
            return $id;
        } else {
            // TODO 添加失败请重试
            return false;
        }
    }

    public function run_task() {

        $list = $this->_list();
        if($list && count($list)) {
            foreach($list as $task) {
                //$id = $params['params']['task_id'] = $task['id'];
                $id = $task['id'];
                if($this->update_task($id,3)){
                    $params = unserialize($task['params']);
                    $params['params']['task_id'] = $id;
                    $controller = $params['model'].'\\Controller\\'.$params['controller'].'Controller';
                    $controller = new $controller();
                    call_user_func_array(array($controller, $params['action']), array($params));
                }
            }
        }
    }

    public function update_task($id,$status){
        $data['id'] = (int)$id;
        $data['update_time'] = time();
        $data['status'] = $status;
        if($this->queue_model->save($data)){
            return true;
        }else{
            return false;
        }
    }

    private function _list() {
        return $this->queue_model->order('id asc')->where('status=2')->select();
//        return $this->queue_model->order('id asc')->select();
    }

    public function download(){
        $task_id = I('get.task_id');
        $queueInfo = M('Queue')->where(array('id' => $task_id))->find();
        $fileInfo = array(
            'file_name' => $queueInfo['name'],
            'file_size' => filesize($queueInfo['file_url']),
        );
        download($queueInfo['file_url'], $fileInfo);
    }

}