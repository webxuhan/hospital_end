<?php
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class ProfileController extends AdminbaseController {
	
	function _initialize(){
		parent::_initialize();
        $this->staff_model = M('staff');
        $this->staff_id = $_SESSION['user']['staff_id'];
	}
    
    
    
    /*
     * 用户头像编辑
     * @author wuxin 2017/02/13
     */
    public function avatar(){
		$this->assign($this->user);
    	$this->display();
    }
    
    /*
     * 用户头像上传
     * @author wuxin 2017/02/13
     */
    public function avatar_upload(){
        echo 333;exit;
    	$config=array(
			'rootPath' => './'.C("UPLOADPATH"),
			'savePath' => './avatar/',
			'maxSize' => 512000,//500K
			'saveName'   =>    array('uniqid',''),
			'exts'       =>    array('jpg', 'png', 'jpeg'),
			'autoSub'    =>    false,
    	);print_r($config);exit;
    	// $upload = new \Think\Upload($config,'Local');//先在本地裁剪
    	// $info=$upload->upload();
    	// //开始上传
    	// if ($info) {
    	// //上传成功
    	// //写入附件数据库信息
    	// 	$first=array_shift($info);
    	// 	$file=$first['savename'];
    	// 	session('avatar',$file);
    	// 	$this->ajaxReturn(sp_ajax_return(array("file"=>$file),L("UPLOADING_SUCCESS"),1),"AJAX_UPLOAD");
    	// } else {
    	// 	//上传失败，返回错误
    	// 	$this->ajaxReturn(sp_ajax_return(array(),$upload->getError(),0),"AJAX_UPLOAD");
    	// }
    }
    
    /*
     * 用户头像裁剪
     * @author wuxin 2017/02/13
     */
    public function avatar_update(){
        $session_avatar=session('avatar');
    	if(!empty($session_avatar)){
    		$targ_w = I('post.w',0,'intval');
    		$targ_h = I('post.h',0,'intval');
    		$x = I('post.x',0,'intval');
    		$y = I('post.y',0,'intval');
    		$jpeg_quality = 90;
    		
    		$avatar=$session_avatar;
    		$avatar_dir=C("UPLOADPATH")."avatar/";
    		
    		$avatar_path=$avatar_dir.$avatar;
    		
    		$image = new \Think\Image();
    		$image->open($avatar_path);
    		$image->crop($targ_w, $targ_h,$x,$y);
    		$image->save($avatar_path);
    		
    		$result=true;
    		
    		$file_upload_type=C('FILE_UPLOAD_TYPE');
    		if($file_upload_type=='Qiniu'){
    		    $upload = new \Think\Upload();
    		    $file=array('savepath'=>'','savename'=>'avatar/'.$avatar,'tmp_name'=>$avatar_path);
    		    $result=$upload->getUploader()->save($file);
    		}
    		if($result===true){
    		    $result=M('Doctor')->where(array("doctor_id"=>1))->save(array("avatar"=>'avatar/'.$avatar));
    		    session('user.avatar','avatar/'.$avatar);
    		    if($result){
    		        $this->success("{:L('AVATAR_UPDATE_SUCCESS')}");
    		    }else{
    		        $this->error("{:L('AVATAR_UPDATE_ERROR')}");
    		    }
    		}else{
    		    $this->error("{:L('AVATAR_SAVE_SUCCESS')}");
    		}
    		
    	}
    }
    
    // 保存用户头像
    public function do_avatar() {
		$imgurl=I('post.imgurl');
		//去'/'
		$imgurl=str_replace('/','',$imgurl);
		$old_img=$this->user['avatar'];
		$this->user['avatar']=$imgurl;
		$res=$this->users_model->where(array("id"=>$this->userid))->save($this->user);		
		if($res){
			//更新session
			session('user',$this->user);
			//删除旧头像
			sp_delete_avatar($old_img);
		}else{
			$this->user['avatar']=$old_img;
			//删除新头像
			sp_delete_avatar($imgurl);
		}
		$this->ajaxReturn($res);
	}       
}