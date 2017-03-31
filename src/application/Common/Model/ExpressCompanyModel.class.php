<?php
/**
 * 快递公司 Model
 *
 * @author Face 2017/01/10
 */

namespace Common\Model;


class ExpressCompanyModel extends CommonModel{
    //自动验证
    protected $_validate = array (
        //array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
        array('express_name', 'require', '{%COMPANY_NAME_NULL}', 1, 'regex', 3),
        array('express_code', 'require', '{%COMPANY_CODE_NULL}', 1, 'regex', 3),
    );

    // 自动完成
    protected $_auto = array (
        // 1：新增 2：更新，3：两者都需要
        array('create_time','time',1,'function'), // 对update_time字段在更新的时候写入当前时间戳
        array('update_time','time',3,'function'), // 对update_time字段在更新的时候写入当前时间戳
    );

    protected function _before_write(&$data) {
        parent::_before_write($data);
    }

}