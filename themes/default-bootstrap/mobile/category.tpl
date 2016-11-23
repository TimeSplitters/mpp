<div>
{include file="$tpl_dir./errors.tpl"}
{if isset($category)}
    {if $category->id AND $category->active}
        <div id="category_subcategories">
        {if isset($subcategories)}
            <div id="accordion" class="panel-group">
                <!-- INFOS -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h2 class="panel-title text-uppercase">
                            <a data-toggle="collapse" data-target="#collapseCategories" class="collapsed"
                               href="#collapseCategories">{$category->name|escape:'html':'UTF-8'}</a>
                        </h2>
                    </div>
                    <div id="collapseCategories" class="collapse">
                        {if (isset($display_subcategories) && $display_subcategories eq 1) || !isset($display_subcategories) }
                            <!-- Subcategories -->
                            <div id="subcategories">
                                <ul class="clearfix">
                                    {foreach from=$subcategories item=subcategory}
                                        <li>
                                            <a href="{$link->getCategoryLink($subcategory.id_category, $subcategory.link_rewrite)|escape:'html':'UTF-8'}">
                                                <span>{$subcategory.name|escape:'html':'UTF-8'}</span>
                                            </a>
                                        </li>
                                    {/foreach}
                                </ul>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        {else}
            {assign var=cat_parent value=$category->getParentsCategories()}
            <div class="panel panel-default">
                <div class="panel-heading panel-heading-force-open">
                    <h2 class="panel-title text-uppercase">
                        {if $category->id_category != 61}
                            {if $category->id_category == 12}
                            <a href="{$link->getCategoryLink(61)|escape:'html':'UTF-8'}" id="subcategory_parent"><span class="icon-angle-left"></span></a>
                            {else}
                            <a href="{$link->getCategoryLink($cat_parent[1].id_category, $cat_parent[1].link_rewrite)|escape:'html':'UTF-8'}" id="subcategory_parent"><span class="icon-angle-left"></span></a>
                            {/if}
                        {/if}
                        {$category->name|escape:'html':'UTF-8'}
                    </h2>
                </div>
            </div>
        {/if}
        </div>
        {if $products}
            {include file="./product-list.tpl" products=$products}
        {/if}
    {elseif $category->id}
        <p class="alert alert-warning">{l s='This category is currently unavailable.'}</p>
    {/if}
{/if}
</div>