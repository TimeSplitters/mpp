{if isset($cms) && !isset($cms_category)}
	{if $cms->id_cms_category == 3}
		{if $cms->id != 20}
			<div class="panel panel-default">
				<div class="panel-heading panel-heading-force-open">
					<h2 class="panel-title text-uppercase">
						<a href="{$link->getCMSLink(20, 'nos-inspirations')|escape:'html':'UTF-8'}" id="subcategory_parent"><span class="icon-angle-left"></span></a> {l s='Nos inspirations'}
					</h2>
				</div>
			</div>

		{else}
			{capture name=path}<span class="navigation_page">{$cms->meta_title}</span>{/capture}
		{/if}
	{/if}

	{if !$cms->active}
		<br />
		<div id="admin-action-cms">
			<p>
				<span>{l s='This CMS page is not visible to your customers.'}</span>
				<input type="hidden" id="admin-action-cms-id" value="{$cms->id}" />
				<input type="submit" value="{l s='Publish'}" name="publish_button" class="button btn btn-default"/>
				<input type="submit" value="{l s='Back'}" name="lnk_view" class="button btn btn-default"/>
			</p>
			<div class="clear" ></div>
			<p id="admin-action-result"></p>
		</div>
	{/if}
	{if $cms->id_cms_category != 3}
		<h1>{$cms->meta_title}</h1>
	{/if}
<div class="rte{if $content_only} content_only{/if}">
	{if $cms->id_cms_category != 3}
		<div class="col-md-3 cms_left">
			<ul id="cms_left_menu">
			</ul>
		</div>
		<div class="col-md-9 content">
			{$cms->content}
		</div>
		<div class="clearfix"></div>
	{else}
		<div id="cms-inspiration" class="content">
			{$cms->content}

			<hr class="clear" />
			<div id="more_inspiration">
				<h3 class="text-center">{l s='Plus d\'inspirations ?'}</h3>
				<p class="text-center">{l s='Retrouvez plus d\'inspirations chaque semaine sur'} <br /><strong><a href="http://www.monpotpourri.com/blog/" target="_blank">{l s='notre Blog'}</a></strong> {l s='et sur'} <strong><a href="https://www.instagram.com/nv.gallery/" target="_blank">{l s='notre compte Instagram'}</a></strong>.</p>
			</div>
			<div class="row">
				<div class="col-md-12 col-xs-12">
					<span class="home_title_bottom_line">#monpotpourri</span>
					<p class="text-center">Vite prenez des photos de votre intérieur et partagez-les sur instagram avec le<br/> hashtag #monpotpourri ! Sinon allez vous inspirer sur notre compte.</p>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 col-sm-6 col-xs-12 instagram">
					{hook h='displayinstagram' mod='instagram_nv'}
				</div>
			</div>
		</div>
		</div>
	{/if}
	</div>
{elseif isset($cms_category)}
	<div class="block-cms">
		{if $cms_category->id_cms_category == 3}
			<h1><a href="{if $cms_category->id eq 1}{$base_dir}{else}{$link->getCMSCategoryLink($cms_category->id, $cms_category->link_rewrite)}{/if}">{$cms_category->name|escape:'html':'UTF-8'}</a></h1>
			{if $cms_category->description}
				<p class="baseline text-center">{$cms_category->description|escape:'html':'UTF-8'}</p>
			{/if}
			<div id="cms-inspiration" class="content">
				{if isset($cms_pages) && !empty($cms_pages)}
					{foreach from=$inspiration_category_content item=cmspghead}
						<a href="{$link->getCMSLink($cmspghead.id_cms, $cmspghead.link_rewrite)|escape:'html':'UTF-8'}">
							{$cmspghead.content}
						</a>
						<hr />
					{/foreach}
				{/if}
			</div>
		{else}
			<h1><a href="{if $cms_category->id eq 1}{$base_dir}{else}{$link->getCMSCategoryLink($cms_category->id, $cms_category->link_rewrite)}{/if}">{$cms_category->name|escape:'html':'UTF-8'}</a></h1>
			{if $cms_category->description}
				<p>{$cms_category->description|escape:'html':'UTF-8'}</p>
			{/if}
			{if isset($sub_category) && !empty($sub_category)}
				<p class="title_block">{l s='List of sub categories in %s:' sprintf=$cms_category->name}</p>
				<ul class="bullet list-group">
					{foreach from=$sub_category item=subcategory}
						<li>
							<a class="list-group-item" href="{$link->getCMSCategoryLink($subcategory.id_cms_category, $subcategory.link_rewrite)|escape:'html':'UTF-8'}">{$subcategory.name|escape:'html':'UTF-8'}</a>
						</li>
					{/foreach}
				</ul>
			{/if}
			{if isset($cms_pages) && !empty($cms_pages)}
				<p class="title_block">{l s='List of pages in %s:' sprintf=$cms_category->name}</p>
				<ul class="bullet list-group">
					{foreach from=$cms_pages item=cmspages}
						<li>
							<a class="list-group-item" href="{$link->getCMSLink($cmspages.id_cms, $cmspages.link_rewrite)|escape:'html':'UTF-8'}">{$cmspages.meta_title|escape:'html':'UTF-8'}</a>
						</li>
					{/foreach}
				</ul>
			{/if}
		{/if}
	</div>
{else}
	<div class="alert alert-danger">
		{l s='This page does not exist.'}
	</div>
{/if}
<br />
{strip}
	{if isset($smarty.get.ad) && $smarty.get.ad}
		{addJsDefL name=ad}{$base_dir|cat:$smarty.get.ad|escape:'html':'UTF-8'}{/addJsDefL}
	{/if}
	{if isset($smarty.get.adtoken) && $smarty.get.adtoken}
		{addJsDefL name=adtoken}{$smarty.get.adtoken|escape:'html':'UTF-8'}{/addJsDefL}
	{/if}
{/strip}
