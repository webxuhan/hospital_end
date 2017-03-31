<?php

/* *
 * 菜单
 */
namespace Common\Model;
use Common\Model\CommonModel;
class PackageAddressModel extends CommonModel {

    //自动验证
    protected $_validate = array(
        //array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
        array('address_name', 'require', '{%ADDRESS_NAME_REQUIRED}', 1, '/^[a-zA-Z0-9_\u4e00-\u9fa5\s]{1,33}$/', CommonModel:: MODEL_BOTH ),
        array('address_detail', 'require', '{%ADDRESS_DETAIL_REQUIRED}', 1, '/^[a-zA-Z0-9_\-\(\)\（\）\u4e00-\u9fa5\s]{1,33}$/', CommonModel:: MODEL_BOTH ),
        
        array('address_name', 'checkAction', '{%SAME_EXIST}', 1, 'callback', 1 ),
        array('address_id,address_name', 'checkActionUpdate', '{%SAME_EXIST}', 1, 'callback', 2),
    );
    //自动完成
    protected $_auto = array(
            //array(填充字段,填充内容,填充条件,附加规则)
    );

    //验证action是否重复添加
    public function checkAction($data) {
        //检查是否重复添加
        $map['address_name'] = $data;
        $map['disabled'] = 0;
        $find = $this->where($map)->find();
        if ($find) {
            return false;
        }
        return true;
    }
    
    //验证action是否重复添加
    public function checkActionUpdate($data) {
        //检查是否重复添加
        $id=$data['address_id'];
        unset($data['address_id']);
        $data['disabled'] = 0;
        $find = $this->field('address_id')->where($data)->find();
        if (isset($find['address_id']) && $find['address_id']!=$id) {
            return false;
        }
        return true;
    }

    /**
     * 更新缓存
     * @param type $data
     * @return type
     */
    public function menu_cache($data = null) {
        if (empty($data)) {
            $data = $this->select();
            F("Menu", $data);
        } else {
            F("Menu", $data);
        }
        return $data;
    }

    /**
     * 后台有更新/编辑则删除缓存
     * @param type $data
     */
    public function _before_write(&$data) {
        parent::_before_write($data);
        F("Menu", NULL);
    }

    //删除操作时删除缓存
    public function _after_delete($data, $options) {
        parent::_after_delete($data, $options);
        $this->_before_write($data);
    }

}