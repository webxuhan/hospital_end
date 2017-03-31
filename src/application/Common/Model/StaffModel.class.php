<?php

/* *
 * 菜单
 */
namespace Common\Model;
use Common\Model\CommonModel;
class StaffModel extends CommonModel {
    //自动验证
    protected $_validate = array(
        //array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
        array('zn_name', 'require', '{%ZN_NAME_REQUIRED}', 1, '/^[\u4e00-\u9fa5\s]{1,33}$/', 3 ),
        array('en_name', 'require', '{%EN_NAME_REQUIRED}', 1, '/^[a-zA-Z\s]{1,99}$/', 3 ),
        array('email', 'email', '{%EMAIL_ERROR}', 1, '', 3 ),

        array('job_number', 'checkAction2', '{%JOB_NUMBER_EXIST}', 2, 'callback', 1),
        array('mobile', 'checkAction3', '{%MOBILE_EXIST}', 2, 'callback', 1),
        array('email,disabled', '', '{%EMAIL_EXIST}', 1, 'unique', 1),

        array('staff_id,email', 'checkActionUpdate', '{%EMAIL_EXIST}', 1, 'callback',2),
        /*array('seat_detail','require', '{%SEAT_NO_REQUIRED}', 1, '', 3),*/
        /*array('seat_detail','', '{%SEAT_NO_ERROR}', 1, '/^[a-zA-Z0-9_\-\(\)\（\（]{1,255}$/', 3),*/
        array('en_name,zn_name,email,seat_id', 'checkAction', '{%SAME_EXIST}', 1, 'callback', 1 ),
    	array('staff_id,en_name,zn_name,receiving_demand,email,seat_id,turnover_status,alias,job_number,mobile,extension_no,department_id,disabled', 'checkActionUpdate', '{%SAME_EXIST}', 1, 'callback',2),
    );
    //自动完成
    protected $_auto = array(
            //array(填充字段,填充内容,填充条件,附加规则)
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
    //验证action是否重复添加
    public function checkAction2($data) {
        //检查是否重复添加
        $map['disabled'] = 0;
        $map['job_number'] = $data;
        $find = $this->where($map)->find();
        if ($find) {
            return false;
        }
        return true;
    }
    //验证action是否重复添加
    public function checkAction3($data) {
        //检查是否重复添加
        $map['disabled'] = 0; 
        $map['mobile'] = $data;
        $find = $this->where($map)->find();
        if ($find) {
            return false;
        }
        return true;
    }

    //验证action是否重复添加
    public function checkActionUpdate($data) {
    	//检查是否重复添加
    	$id=$data['staff_id'];
    	unset($data['staff_id']);
        $data['disabled'] = 0;
    	$find = $this->field('staff_id')->where($data)->find();
    	if (isset($find['staff_id']) && $find['staff_id']!=$id) {
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