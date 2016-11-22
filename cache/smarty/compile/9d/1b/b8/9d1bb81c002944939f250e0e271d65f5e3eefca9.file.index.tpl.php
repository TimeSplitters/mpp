<?php /* Smarty version Smarty-3.1.19, created on 2016-11-22 21:52:56
         compiled from "/Users/christopheabillama/Documents/workspace/potpourri/themes/default-bootstrap/index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:462064990582dd7c97ae6d2-71905269%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '9d1bb81c002944939f250e0e271d65f5e3eefca9' => 
    array (
      0 => '/Users/christopheabillama/Documents/workspace/potpourri/themes/default-bootstrap/index.tpl',
      1 => 1479847917,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '462064990582dd7c97ae6d2-71905269',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.19',
  'unifunc' => 'content_582dd7c9898080_31031331',
  'variables' => 
  array (
    'HOOK_HOME_TAB_CONTENT' => 0,
    'HOOK_HOME_TAB' => 0,
    'HOOK_HOME' => 0,
    'cmsConcept' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_582dd7c9898080_31031331')) {function content_582dd7c9898080_31031331($_smarty_tpl) {?><?php if (isset($_smarty_tpl->tpl_vars['HOOK_HOME_TAB_CONTENT']->value)&&trim($_smarty_tpl->tpl_vars['HOOK_HOME_TAB_CONTENT']->value)) {?>
    <?php if (isset($_smarty_tpl->tpl_vars['HOOK_HOME_TAB']->value)&&trim($_smarty_tpl->tpl_vars['HOOK_HOME_TAB']->value)) {?>
        <ul id="home-page-tabs" class="nav nav-tabs clearfix">
			<?php echo $_smarty_tpl->tpl_vars['HOOK_HOME_TAB']->value;?>

		</ul>
	<?php }?>
	<div class="tab-content"><?php echo $_smarty_tpl->tpl_vars['HOOK_HOME_TAB_CONTENT']->value;?>
</div>
<?php }?>
<?php if (isset($_smarty_tpl->tpl_vars['HOOK_HOME']->value)&&trim($_smarty_tpl->tpl_vars['HOOK_HOME']->value)) {?>
	<div class="clearfix"><?php echo $_smarty_tpl->tpl_vars['HOOK_HOME']->value;?>
</div>
<?php }?>

<h1><?php echo smartyTranslate(array('s'=>'Pot Pourri, boîte culturelle'),$_smarty_tpl);?>
</h1>
<?php $_smarty_tpl->tpl_vars['cmsConcept'] = new Smarty_variable(CMS::getCMSContent(6), null, 0);?>
<?php echo $_smarty_tpl->tpl_vars['cmsConcept']->value['content'];?>
<?php }} ?>
