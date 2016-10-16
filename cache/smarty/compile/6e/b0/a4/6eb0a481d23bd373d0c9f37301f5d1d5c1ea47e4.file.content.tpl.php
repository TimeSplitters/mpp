<?php /* Smarty version Smarty-3.1.19, created on 2016-10-16 21:09:24
         compiled from "/Users/christopheabillama/Documents/workspace/potpourri/admin111sqojfi/themes/default/template/content.tpl" */ ?>
<?php /*%%SmartyHeaderCode:10298341415803d064431de2-60257147%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '6eb0a481d23bd373d0c9f37301f5d1d5c1ea47e4' => 
    array (
      0 => '/Users/christopheabillama/Documents/workspace/potpourri/admin111sqojfi/themes/default/template/content.tpl',
      1 => 1473167112,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '10298341415803d064431de2-60257147',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'content' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.19',
  'unifunc' => 'content_5803d064440709_43209354',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5803d064440709_43209354')) {function content_5803d064440709_43209354($_smarty_tpl) {?>
<div id="ajax_confirmation" class="alert alert-success hide"></div>

<div id="ajaxBox" style="display:none"></div>


<div class="row">
	<div class="col-lg-12">
		<?php if (isset($_smarty_tpl->tpl_vars['content']->value)) {?>
			<?php echo $_smarty_tpl->tpl_vars['content']->value;?>

		<?php }?>
	</div>
</div><?php }} ?>
