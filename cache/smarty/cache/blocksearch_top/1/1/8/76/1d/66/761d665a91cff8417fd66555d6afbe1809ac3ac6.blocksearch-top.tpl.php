<?php /*%%SmartyHeaderCode:923578815803d091612b95-44358658%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '761d665a91cff8417fd66555d6afbe1809ac3ac6' => 
    array (
      0 => '/Users/christopheabillama/Documents/workspace/potpourri/themes/default-bootstrap/modules/blocksearch/blocksearch-top.tpl',
      1 => 1473167114,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '923578815803d091612b95-44358658',
  'version' => 'Smarty-3.1.19',
  'unifunc' => 'content_5803d4b5de9456_34911007',
  'has_nocache_code' => false,
  'cache_lifetime' => 31536000,
),true); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5803d4b5de9456_34911007')) {function content_5803d4b5de9456_34911007($_smarty_tpl) {?><!-- Block search module TOP -->
<div id="search_block_top" class="col-sm-4 clearfix">
	<form id="searchbox" method="get" action="//potpourri.local/recherche" >
		<input type="hidden" name="controller" value="search" />
		<input type="hidden" name="orderby" value="position" />
		<input type="hidden" name="orderway" value="desc" />
		<input class="search_query form-control" type="text" id="search_query_top" name="search_query" placeholder="Rechercher" value="" />
		<button type="submit" name="submit_search" class="btn btn-default button-search">
			<span>Rechercher</span>
		</button>
	</form>
</div>
<!-- /Block search module TOP --><?php }} ?>
