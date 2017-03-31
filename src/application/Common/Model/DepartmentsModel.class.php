<?php
/**
 * Departments(部门管理)
 */
namespace Common\Model;
use Common\Model\CommonModel;
class DepartmentsModel extends CommonModel {

    /**
    * 自动验证
    *
    * @author PanF 2017/01/16
    */
    protected $_validate = array(
        //array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
        array('department_name', 'require', '{%NAME_MUST}', 1, 'regex', CommonModel:: MODEL_BOTH ),
        array('department_name', 'checkAction', '{%THE_SAME_EXIT}', 1, 'callback', CommonModel:: MODEL_INSERT),
    	array('department_id,department_name,disabled', 'checkActionUpdate', '{%THE_SAME_EXIT}', 1, 'callback', CommonModel:: MODEL_UPDATE   ),
    );


    /**
    * 自动完成
    *
    * @author PanF 2017/01/16
    */
    protected $_auto = array(
            //array(填充字段,填充内容,填充条件,附加规则)
        // 1：新增 2：更新，3：两者都需要
        array('create_time','time',1,'function'), // 对update_time字段在更新的时候写入当前时间戳
        array('update_time','time',3,'function'), // 对update_time字段在更新的时候写入当前时间戳
    );



    /**
    * 验证action是否重复添加
    *
    * @author PanF 2017/01/16
    */
    public function checkAction($data) {
        $map['department_name'] = $data;
        $map['disabled'] = 0;
        //检查是否重复添加
        $find = $this->where($map)->find();
        if ($find) {
            return false;
        }
        return true;
    }

    /**
    * 验证更新时action是否重复添加
    *
    * @author PanF 2017/01/16
    */
    public function checkActionUpdate($data) {
    	//检查是否重复添加
    	$id=$data['department_id'];
    	unset($data['department_id']);
    	$find = $this->field('department_id')->where($data)->find();
    	if (isset($find['department_id']) && $find['department_id']!=$id) {
    		return false;
    	}
    	return true;
    }

}