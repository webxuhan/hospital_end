<?php
namespace Common\Model;
use Common\Model\CommonModel;
class RegionsModel extends CommonModel{
	//自动验证
	protected $_validate = array(
			//array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
			array('name', 'require', '{%REGION_NAME_REQUIRED}', 1),
			array('parent_name', 'require', '{%PRE_REGION_REQUIRED}', 1),
			array('name,parentid,id', 'checkActionUpdate', '{%SAME_EXIST}', 1,'callback',2),
			array('name,parentid', 'checkAction', '{%SAME_EXIST}', 1, 'callback', 1 ),
	);
	//自动完成
	protected $_auto = array ( 
          //array('parename','getName',3,'callback'), // 对name字段在新增和编辑的时候回调getName方法
         
     );
	
	//验证action是否重复添加
    public function checkAction($data) {
        //检查是否重复添加
        $data['disabled'] = 0;
        $find = $this->where($data)->find();
        if ($find) {
            return false;
        }
        return true;
    }

	//验证action是否重复编辑
    public function checkActionUpdate($data) {
    	//检查是否重复添加
    	$id=$data['id'];
    	unset($data['id']);
        $data['disabled'] = 0;
    	$find = $this->field('id')->where($data)->find();
    	if (isset($find['id']) && $find['id']!=$id) {
    		return false;
    	}
    	return true;
    }
}