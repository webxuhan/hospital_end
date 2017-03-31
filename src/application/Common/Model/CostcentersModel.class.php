<?php
/**
 * Costcenters(成本中心管理)
 */
namespace Common\Model;
use Common\Model\CommonModel;
class CostcentersModel extends CommonModel {

    /**
    * 自动验证
    *
    * @author PanF 2017/01/16
    */
    protected $_validate = array(
        //array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
        array('center_name', 'require', '{%NAME_MUST}', 1, 'regex', CommonModel:: MODEL_BOTH ),
        array('center_name',  'checkAction','{%THE_SAME_EXIT}', 1, 'callback', CommonModel:: MODEL_INSERT   ),
    	array('center_id,center_name,disabled', 'checkActionUpdate', '{%THE_SAME_EXIT}', 1, 'callback', CommonModel:: MODEL_UPDATE   ),
    );

    /**
    * 自动完成
    *
    * @author PanF 2017/01/16
    */
    protected $_auto = array(
            //array(填充字段,填充内容,填充条件,附加规则)
    );



    /**
    * 验证action是否重复添加
    *
    * @author PanF 2017/01/16
    */
    public function checkAction($data) {
        //检查是否重复添加
        $map['disabled'] = 0;
        $map['center_name'] = $data;
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
    	$id=$data['center_id'];
    	unset($data['center_id']);
        
    	$find = $this->field('center_id')->where($data)->find();
    	if (isset($find['center_id']) && $find['center_id']!=$id) {
    		return false;
    	}
    	return true;
    }

}