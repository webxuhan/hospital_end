<?php
/**
 * Created by PhpStorm.
 * User: zhao
 * Date: 2017/2/13
 * Time: 下午2:32
 */


/**
 * 获取员工
 * @param $staff_id 员工id
 * @return mixed|null 员工或空
 */
function getStaff($staff_id)
{
    $staff_model = D("Common/Staff");

    //建立员工查询条件，基础条件未删除、在职。
    $map['sm.disabled'] = 0;
    //$map['turnover_status'] = 0;
    if ($staff_id != null) {
        $map['sm.staff_id'] = $staff_id;
        $db_prefix = C('DB_PREFIX');
        $staff = $staff_model
            ->alias('sm')
            ->join("left join {$db_prefix}departments as d on sm.department_id = d.department_id ")
            ->where($map)
            ->find();
        return $staff;
    }
    return null;
}

/**
 * 员工条件查询列表
 */
function searchStaff()
{

}

/**
 * 获取快递公司列表
 * @param $express_type 快递类型  0：国内，1：国际
 * @return mixed
 */
function getExpressCompanyList($express_type)
{
    $expressCompanyModel = D("Common/ExpressCompany");
    $where['disabled'] = 0;
    if ($express_type!=null) {
        $where['express_type'] = $express_type;
    }
    $list = $expressCompanyModel
        ->where($where)
        ->order('express_name asc')
        ->select();
    return $list;
}

/**
 * 获取快递公司信息通过ID
 * @param $id
 * @return mixed
 */
function getExpressCompanyById($id){
    $expressCompanyModel = D("Common/ExpressCompany");
    $where['express_id'] = $id;

    $express = $expressCompanyModel->where($where)->find();

    return $express;
}

/**
 * 生成流水号
 * 通过参数传过来的模型找到模型最新一条的流水号，并截取后重新组装并+1返回
 * @param $obj 模型对象
 * @return number 流水号
 */
function getSerialNumber($mod, $t)
{
    //获取当天的开始结束时间。
    $time1 = strtotime(date("Y-m-d", time()));//今天0点的时间点
    $time2 = $time1 + 3600 * 24;//今天24点的时间点，两个值之间即为今天一天内的数据

    $sendingModel = D('Express/Sending');

    //根据条件查询数据
    $number = $sendingModel
        ->where("create_time > '$time1' and create_time <= '$time2'")
        ->order('id desc')
        ->limit(1)
        ->select();

    //设置其实数量号
    $day_number = 1;
    //判断是否有数据
    if ($number) {
        foreach ($number as $one) {
            $day_number = $one['day_number'] + 1;
        }
    }
    //获取今天的日期 格式如：170215
    $time = date('ymd', time());
    //流水号补位
    $day_number = str_pad($day_number, 6, "0", STR_PAD_LEFT);
    $serialNumber = $mod . $t . $time . $day_number;
    $retArray = array();
    $retArray['serialNumber'] = $serialNumber;
    $retArray['dayNumber'] = $day_number;
    return $retArray;
}


/**
 * 取得部门信息
 *
 * @return boolen  or  array
 */
function getDepartment()
{
    $departments = M('Departments')->getField('department_id,department_name');
    if ($departments) {
        return $departments;
    } else {
        return false;
    }
}

/**
 * 运费计算公式
 * @param $regions_id
 * @param $express_type
 * @param $express_company_id
 * @param $weight
 * @return $expenses
 */
function getFreightCalculation($region_id, $express_type, $express_company_id, $weight)
{

    //国内首重模型
    $fwPricesModel = D('Common/Expressfwprices');
    //国内阶梯模型
    $ladderPricesModel = D('Common/Expressladderprices');
    //国际运费模型
    $interExpressPricesModel = D('Common/Expressinterprices');

    $where['express_id'] = $express_company_id;
    //判断是国内还是国际
    if ($express_type == 0) {
        $weight = ceil($weight);
        $where['region_ids'] = get_search_str($region_id);
        //根据区域ID 和 快递公司查询到首重记录。
        $fpm = $fwPricesModel->where($where)->find();
        $expenses = $fpm['price'];
        if ($fpm) {
            //通过首重记录的ID 找到阶梯记录列表
            $map['fw_price_id'] = $fpm['fw_price_id'];
            $condition['weight_start'] = array("ELT", $weight);
            $condition['weight_end'] = array("ELT", $weight);
            $condition['_logic'] = 'OR';
            $map['_complex'] = $condition;
            $ladderPrice = $ladderPricesModel->where($map)->select();
            foreach ($ladderPrice as $p) {
                //如果商品总量大于阶梯总量的最大值计算。
                if ($weight > $p['weight_end']) {
                    $w = $p['weight_end'] - $p['weight_start'] + 1;
                } else {
                    $w = $weight - $p['weight_start'] + 1;
                }
                $expenses += $w * $p['ladder_price'];
            }
            $retArray['price'] = $expenses;
        }
    } else if ($express_type == 1) { //国际快递
        $w1 = intval($weight);
        $w2 = explode(".", $weight);
        $w2 = $w2[1];
        $w2 = $w2[0];
        if ($w2 > 0) {
            if ($w2 < 5) {
                $weight = $w1 + 0.5;
            } else if ($w2 > 5) {
                $weight = $w1 + 1;
            }
        }
        $where['region_id'] = get_search_str($region_id);
        $where['weight'] = $weight;
        $interPrices = $interExpressPricesModel->where($where)->find();
        $expenses = $interPrices['price'] * $interPrices['discount'];

    }
    return $expenses;
}


/**
 * 获取最优的快递与价格
 * @param $region_id 收件地址
 * @param $weight 重量
 * @param $express_type 快递类型
 */
function getBestExpress($region_id, $express_type, $weight)
{
    $expressList = getExpressCompanyList($express_type);
    $expressId = null;
    $expressPrice = 0;
    foreach ($expressList as $express) {
        $price = getFreightCalculation($region_id, $express_type, $express['express_id'], $weight);
        if ($expressPrice == 0 && $price && $price > 0) {
            $expressPrice = $price;
            $expressId = $express['express_id'];
        }
        if ($expressPrice > $price && $price && $price > 0) {
            $expressPrice = $price;
            $expressId = $express['express_id'];
        }
    }
    $retArray = array("expressId" => $expressId, "expressPrice" => $expressPrice);
    return $retArray;
}

/**
 * 获取目的地列表
 */
function getPackageAddress(){
    $packageAddressModel = D("Common/PackageAddress");
    $where['disabled'] = 0;
    $address_list = $packageAddressModel->where($where)->select();
    return $address_list;
}

/**
 * 获取目的地信息根据ID
 * @param $id
 * @return mixed
 *
 */
function findPackageAddressById($id){
    $packageAddressModel = D("Common/PackageAddress");
    $where['address_id'] = $id;
    $address = $packageAddressModel->where($where)->find();
    return $address;
}

