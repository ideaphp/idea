<form class="form-horizontal" role="form">

<ul class="nav nav-tabs">
  <li class="active"><a href="#users" data-toggle="tab">主要信息</a></li>
  <li><a href="#user_system" data-toggle="tab">系统信息</a></li>
  <li><a href="#user_profile" data-toggle="tab">扩展信息</a></li>
</ul><!-- /.nav nav-tabs -->

<div class="tab-content">
  <div class="tab-pane fade active in" id="users">
    <?php include "users_create_form_users.html.php"; ?>
  </div>
  <div class="tab-pane fade" id="user_system">
    <?php include "users_create_form_user_system.html.php"; ?>
  </div>
  <div class="tab-pane fade" id="user_profile">
    <?php include "users_create_form_user_profile.html.php"; ?>
  </div>
</div><!-- /.tab-content -->

<div class="form-group">
  <div class="col-lg-1"></div>
  <div class="col-lg-11">
    <button type="button" class="btn btn-primary input-sm">
  	  <span class="glyphicon glyphicon-save"></span>
  	  保存
  	</button>
    <button type="button" class="btn btn-default input-sm">
  	  <span class="glyphicon glyphicon-ok-sign"></span>
  	  保存并关闭
  	</button>
    <button type="button" class="btn btn-default input-sm">
  	  <span class="glyphicon glyphicon-plus-sign"></span>
  	  保存并新建
  	</button>
    <button type="button" class="btn btn-danger input-sm">
  	  <span class="glyphicon glyphicon-remove-sign"></span>
  	  取消
  	</button>
  </div>
</div><!-- /.form-group -->

</form>
