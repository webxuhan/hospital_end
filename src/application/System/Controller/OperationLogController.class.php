<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/9
 * Time: 14:16
 */

namespace System\Controller;

use Think\Controller;
class OperationLogController {

    protected $operation_model;
    public $error;//错误信息

    public function _initialize() {
        $this->operation_model = M('OperationLog');
    }

    /**
     * 写入操作日志
     * @param string $operation_content 写入操作内容
     * @author luchaonan 2017/01/23
     */
    public function writeLog($operation_content){
        $data['operation_time'] = time();
        //获取用户id
        $uid = session('ADMIN_ID');
        $data['operation_uid'] = ($uid) ? $uid : 0;

        $Ip = new \Org\Net\IpLocation();

        // 获取某个IP地址所在的位置
        $ip_info = $Ip->getlocation($this->getClientIp());
        $ip_info['country'] = iconv('gbk', 'utf-8', $ip_info['country']);
        $ip_info['area'] = iconv('gbk', 'utf-8', $ip_info['area']);

        $data['operation_ip'] = serialize($ip_info);
        $data['operation_content'] = $operation_content;
        $data['operation_node'] = $_SERVER['QUERY_STRING'];
        $data['operation_node'] || $data['operation_node'] = 'System';

        $result  =  M('OperationLog')->add($data);
    }

    /**
     * 获取客户端IP地址
     * @param integer $type 返回类型 0 返回IP地址 1 返回IPV4地址数字
     * @return mixed
     * @author luchaonan 2017/01/23
     */
    private function getClientIp($type=0){
        $type       =  $type ? 1 : 0;
        static $ip  =   NULL;
        if ($ip !== NULL) return $ip[$type];
        if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
            $arr    =   explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
            $pos    =   array_search('unknown',$arr);
            if(false !== $pos) unset($arr[$pos]);
            $ip     =   trim($arr[0]);
        }elseif (isset($_SERVER['HTTP_CLIENT_IP'])) {
            $ip     =   $_SERVER['HTTP_CLIENT_IP'];
        }elseif (isset($_SERVER['REMOTE_ADDR'])) {
            $ip     =   $_SERVER['REMOTE_ADDR'];
        }

        // IP地址合法验证
        $long = sprintf("%u",ip2long($ip));
        $ip   = $long ? array($ip, $long) : array('0.0.0.0', 0);

        return $ip[$type];
    }
}