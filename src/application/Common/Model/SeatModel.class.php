<?php
/**
 * Departments(部门管理)
 */
namespace Common\Model;
use Common\Model\CommonModel;
class SeatModel extends CommonModel {

    /**
     * 自动验证
     *
     * @author wuzhipeng 2017/02/13
     */
    protected $_validate = array(
        //array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
        array('seat_detail', 'require', '{%CONTANT_MUST}', 1, 'regex', CommonModel:: MODEL_BOTH ),
        array('seat_detail', 'checkAction', '{%THE_SAME_EXIT}', 1, 'callback', CommonModel:: MODEL_INSERT   ),
        array('seat_id,seat_detail', 'checkActionUpdate', '{%THE_SAME_EXIT}', 1, 'callback', CommonModel:: MODEL_UPDATE   ),


    );


    /**
     * 自动完成
     *
     * @author wuzhipeng 2017/02/13
     */
    protected $_auto = array(
        //array(填充字段,填充内容,填充条件,附加规则)
        // 1：新增 2：更新，3：两者都需要
        array('create_time','time',1,'function'), // 对create_time字段在更新的时候写入当前时间戳
        array('update_time','time',3,'function'), // 对update_time字段在更新的时候写入当前时间戳
    );



    /**
     * 验证action是否重复添加
     *
     * @author wuzhipeng 2017/02/13
     */
    public function checkAction($data) {
        //检查是否重复添加
        $find = $this->where(array('seat_detail'=>$data,'disabled'=>'0'))->find();
        if ($find) {
            return false;
        }
        return true;
    }

    /**
     * 验证更新时action是否重复添加
     *
     * @author wuzhipeng 2017/02/13
     */
    public function checkActionUpdate($data) {
        //检查是否重复添加
        $id=$data['seat_id'];
        unset($data['seat_id']);
        $find = $this->field('seat_id')->where(array('seat_detail'=>$data['seat_detail'],'disabled'=>'0'))->find();
        if (isset($find['seat_id']) && $find['seat_id']!=$id) {
            return false;
        }
        return true;
    }


}