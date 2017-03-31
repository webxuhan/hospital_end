<?php
namespace Common\Model;

use Common\Model\CommonModel;

class ExpressTemplateModel extends CommonModel{

	//自动验证
	protected $_validate = array(
		//array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
		array('express_tpl_name', 'require', '{%NAME_MUST}！', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
		array('express_tpl_encode', 'require', '{%NAME_MUST}！', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
		array('express_tpl_name', 'checkAction', '{%THE_SAME_EXIT}', 1, 'callback', CommonModel:: MODEL_INSERT   ),
		array('id,express_tpl_name', 'checkActionUpdate', '{%THE_SAME_EXIT}', 1, 'callback', CommonModel:: MODEL_UPDATE   ),
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
		$find = $this->where(array('express_tpl_name'=>$data,'disabled'=>'0'))->find();
//		print_r($find);die;
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
		$id=$data['id'];
		$find = $this->field('id')->where(array('express_tpl_name'=>$data['express_tpl_name'],'disabled'=>'0'))->find();
		if (isset($find['id']) && $find['id']!=$id) {
			return false;
		}
		return true;
	}

}
