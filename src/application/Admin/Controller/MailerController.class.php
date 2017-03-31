<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2014 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Tuolaji <479923197@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class MailerController extends AdminbaseController {

    // SMTP配置
    public function index() {
    	$this->display();
    }
    
    // SMTP配置处理
    public function index_post() {
    	$post = array_map('trim', I('post.'));
    	
    	if(in_array('', $post) && !empty($post['smtpsecure'])) $this->error("不能留空！");
    	
    	$configs['SP_MAIL_ADDRESS'] = $post['address'];
    	$configs['SP_MAIL_SENDER'] = $post['sender'];
    	$configs['SP_MAIL_SMTP'] = $post['smtp'];
		$configs['SP_MAIL_SECURE'] = $post['smtpsecure'];
    	$configs['SP_MAIL_SMTP_PORT'] = $post['smtp_port'];
    	$configs['SP_MAIL_LOGINNAME'] = $post['loginname'];
    	$configs['SP_MAIL_PASSWORD'] = $post['password'];
    	$result=sp_set_dynamic_config($configs);
    	sp_clear_cache();
    	if ($result) {
    		$this->success("保存成功！");
    	} else {
    		$this->error("保存失败！");
    	}
    }
    
    // 邮件模板分类页
    public function active(){
    	$this->display();
    }

    // 邮件模板分类页提交
    public function active_post(){
        $configs = array();
        $templet = array('location','stamp','sendfalse','sendtrue','order','affirm');
        foreach(I('post.lightup') as $value){
            foreach($templet as $val){//关闭没有选择的数据
                if($val != $value){
                    $str = 'SP_'.$val.'_EMAIL_ACTIVE';
                    $configs[$str] = 0;
                    $result = sp_set_dynamic_config($configs);
                }
            }
            if($result){
                //开启已选择的数据
                $str1 = 'SP_'.$value.'_EMAIL_ACTIVE';
                $configs1[$str1] = 1;
                $result1 = sp_set_dynamic_config($configs1);
                if($result1){
                    $this->success(L("EDIT_SUCCESS"), U('Mailer/active'));
                }

            }       
        }   
    }

    //邮件模板详情页
    public function templet(){
        if(isset($_POST['style'])){
            $where['option_name'] = 'member_email_active_'.I('post.style');
            $ids = $_POST['ids'];
        }else{
            $where['option_name'] = 'member_email_active_'.I('get.style');
        }
        $option = M('Options')->where($where)->find();
        if($option){
            $options = json_decode($option['option_value'], true);
            $this->assign('options', $options);
            $this->assign('option_name',$where['option_name']);
            if($ids){
                $this->assign('ids',$ids);
            }
        }

        $this->display();
    }
    
    // 邮件模板详情页提交
     public function templet_post(){
       // print_r($_POST);
        $option_name = I('post.option_name/a');
        $option_name = (string)$option_name[0];
        
        $options=I('post.options/a');
        $options['template']=htmlspecialchars_decode($options['template']);

        $data=array();
        $data['option_name'] = $option_name; 
        $data['option_value']= json_encode($options);
        $options_model= M('Options');
        if($options_model->where("option_name='".$option_name."'")->find()){
            $result = $options_model->where("option_name='".$option_name."'")->save($data);
        }else{
            $result = $options_model->add($data);
        }
        
        if ($result!==false) {
            if($_POST['ids']){
                $this->sendEmail();
            }else{
                $this->success(L("EDIT_SUCCESS"));
            }
            
        } else {
            $this->error(L("EDIT_FAILED"));
        }
    }
    // 邮件发送
    public function sendEmail(){//加参数
        if(IS_POST){
            $result = 1;
            $ids = $_POST['ids'];
            $emails = M("Staff")->where(array('staff_id'=>array('in',$ids)))->field('email')->select();
            foreach($emails as $email){
                $result=sp_send_email($email, $options['title'], $options['template']);
                if(!$result){
                    $result = 0;
                }
            }
            if($result && empty($result['error'])){
                $this->success('发送成功！');
            }else{
                $this->error('发送失败：'.$result['message']);
            }
        }
    }
    
    // 邮件发送测试
    public function test(){//加参数
        if(IS_POST){

            $rules = array(
                 array('to','require','收件箱不能为空！',1,'regex',3),//员工表中得到id的那几个人的邮箱
                 array('to','email','收件箱格式不正确！',1,'regex',3),
                 array('subject','require','标题不能为空！',1,'regex',3),
                 array('content','require','内容不能为空！',1,'regex',3),
            );
            
            $model = M(); // 实例化User对象
            if ($model->validate($rules)->create()!==false){
                $data=I('post.');
                $result=sp_send_email($data['to'], $data['subject'], $data['content']);
                if($result && empty($result['error'])){
                    $this->success('发送成功！');
                }else{
                    $this->error('发送失败：'.$result['message']);
                }
            }else{
                $this->error($model->getError());
            }
            
        }else{
            $this->display();
        }
        
    }
    

}

