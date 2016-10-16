<?php /* Smarty version Smarty-3.1.19, created on 2016-10-16 21:09:27
         compiled from "/Users/christopheabillama/Documents/workspace/potpourri/admin111sqojfi/themes/default/template/controllers/modules/warning_module.tpl" */ ?>
<?php /*%%SmartyHeaderCode:6339618435803d067bb3976-42098522%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'd6baff43913b02eed5af0750a78ed05afdb74067' => 
    array (
      0 => '/Users/christopheabillama/Documents/workspace/potpourri/admin111sqojfi/themes/default/template/controllers/modules/warning_module.tpl',
      1 => 1473167112,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '6339618435803d067bb3976-42098522',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'module_link' => 0,
    'text' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.19',
  'unifunc' => 'content_5803d067be0649_89543527',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5803d067be0649_89543527')) {function content_5803d067be0649_89543527($_smarty_tpl) {?>
<a href="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['module_link']->value, ENT_QUOTES, 'UTF-8', true);?>
"><?php echo $_smarty_tpl->tpl_vars['text']->value;?>
</a><?php }} ?>
