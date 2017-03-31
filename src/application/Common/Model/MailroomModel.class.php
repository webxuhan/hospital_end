<?php
/**
 * Departments(部门管理)
 */
namespace Common\Model;
use Common\Model\CommonModel;
class MailroomModel extends CommonModel {

    /**
     * 自动验证
     *
     * @author wuzhipeng 2017/02/13
     */
    protected $_validate = array(
        //array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
        array('mailroom_name', 'require', '{%NAME_MUST}', 1, 'regex', CommonModel:: MODEL_BOTH ),
        array('mailroom_name', 'checkAction', '{%THE_SAME_EXIT}', 1, 'callback', CommonModel:: MODEL_INSERT   ),
        array('mailroom_id,mailroom_name', 'checkActionUpdate', '{%THE_SAME_EXIT}', 1, 'callback', CommonModel:: MODEL_UPDATE   ),
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
        $find = $this->where(array('mailroom_name'=>$data,'disabled'=>'0'))->find();
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
        $id=$data['mailroom_id'];
        $find = $this->field('mailroom_id')->where(array('mailroom_name'=>$data['mailroom_name'],'disabled'=>'0'))->find();
        if (isset($find['mailroom_id']) && $find['mailroom_id']!=$id) {
            return false;
        }
        return true;
    }

}