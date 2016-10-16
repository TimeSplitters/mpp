<?php /* Smarty version Smarty-3.1.19, created on 2016-10-16 21:09:24
         compiled from "/Users/christopheabillama/Documents/workspace/potpourri/admin111sqojfi/themes/default/template/helpers/modules_list/modal.tpl" */ ?>
<?php /*%%SmartyHeaderCode:7898730735803d064668fe3-11170813%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '88d9a0bda5ee3067ca5bc10a83bd9e23356c7e65' => 
    array (
      0 => '/Users/christopheabillama/Documents/workspace/potpourri/admin111sqojfi/themes/default/template/helpers/modules_list/modal.tpl',
      1 => 1473167112,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '7898730735803d064668fe3-11170813',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.19',
  'unifunc' => 'content_5803d06466ee37_70573708',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5803d06466ee37_70573708')) {function content_5803d06466ee37_70573708($_smarty_tpl) {?><div class="modal fade" id="modules_list_container">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h3 class="modal-title"><?php echo smartyTranslate(array('s'=>'Recommended Modules and Services'),$_smarty_tpl);?>
</h3>
			</div>
			<div class="modal-body">
				<div id="modules_list_container_tab_modal" style="display:none;"></div>
				<div id="modules_list_loader"><i class="icon-refresh icon-spin"></i></div>
			</div>
		</div>
	</div>
</div>
<?php }} ?>
