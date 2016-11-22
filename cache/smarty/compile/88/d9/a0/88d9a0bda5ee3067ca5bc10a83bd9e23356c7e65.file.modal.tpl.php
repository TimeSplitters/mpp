<?php /* Smarty version Smarty-3.1.19, created on 2016-11-17 17:15:18
         compiled from "/Users/christopheabillama/Documents/workspace/potpourri/admin111sqojfi/themes/default/template/helpers/modules_list/modal.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1941480531582dd79654b111-17370699%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '88d9a0bda5ee3067ca5bc10a83bd9e23356c7e65' => 
    array (
      0 => '/Users/christopheabillama/Documents/workspace/potpourri/admin111sqojfi/themes/default/template/helpers/modules_list/modal.tpl',
      1 => 1479399255,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1941480531582dd79654b111-17370699',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.19',
  'unifunc' => 'content_582dd796551464_41799087',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_582dd796551464_41799087')) {function content_582dd796551464_41799087($_smarty_tpl) {?><div class="modal fade" id="modules_list_container">
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
