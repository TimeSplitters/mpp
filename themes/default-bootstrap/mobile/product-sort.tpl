{if isset($orderby) AND isset($orderway)}
    {*<ul class="display hidden-xs">
        <li class="display-title">{l s='View:'}</li>
        <li id="grid"><a rel="nofollow" href="#" title="{l s='Grid'}"><i class="icon-th-large"></i>{l s='Grid'}</a></li>
        <li id="list"><a rel="nofollow" href="#" title="{l s='List'}"><i class="icon-th-list"></i>{l s='List'}</a></li>
    </ul>*}
    {* On 1.5 the var request is setted on the front controller. The next lines assure the retrocompatibility with some modules *}
    {if !isset($request)}
        <!-- Sort products -->
        {if isset($smarty.get.id_category) && $smarty.get.id_category}
            {assign var='request' value=$link->getPaginationLink('category', $category, false, true)
            }    {elseif isset($smarty.get.id_manufacturer) && $smarty.get.id_manufacturer}
            {assign var='request' value=$link->getPaginationLink('manufacturer', $manufacturer, false, true)}
        {elseif isset($smarty.get.id_supplier) && $smarty.get.id_supplier}
            {assign var='request' value=$link->getPaginationLink('supplier', $supplier, false, true)}
        {else}
            {assign var='request' value=$link->getPaginationLink(false, false, false, true)}
        {/if}
    {/if}

    {if $page_name == 'best-sales' && (!isset($smarty.get.orderby) || empty($smarty.get.orderby))}{$orderby = ''}{$orderbydefault = ''}{/if}
    <form id="productsSortForm{if isset($paginationId)}_{$paginationId}{/if}" action="{$request|escape:'html':'UTF-8'}"
          class="productsSortForm">
        <div class="select selector1">
            <label for="selectProductSort{if isset($paginationId)}_{$paginationId}{/if}">{l s='Sort by'}</label>
            <select id="selectProductSort{if isset($paginationId)}_{$paginationId}{/if}"
                    class="selectProductSort form-control">
                <option value="date_add:desc"{if isset($smarty.get.orderby) && $smarty.get.orderby eq 'date_add' AND $orderway eq 'desc'}
                    selected="selected"{/if}>{l s='Latest products'}</option>
                <option value="popularity:desc"{if isset($smarty.get.orderby) && $smarty.get.orderby eq 'popularity' AND $orderway eq 'desc'}
                    selected="selected"{/if}>{l s='Popularity (best sales)'}</option>
                {if !$PS_CATALOG_MODE}
                    <option value="price:asc"{if isset($smarty.get.orderby) && $smarty.get.orderby eq 'price' AND $orderway eq 'asc'} selected="selected"{/if}>{l s='Price: Lowest first'}</option>
                    <option value="price:desc"{if isset($smarty.get.orderby) && $smarty.get.orderby eq 'price' AND $orderway eq 'desc'} selected="selected"{/if}>{l s='Price: Highest first'}</option>
                {/if}
                {if $PS_STOCK_MANAGEMENT && !$PS_CATALOG_MODE}
                    {*<option value="quantity:desc"{if $orderby eq 'quantity' AND $orderway eq 'desc'} selected="selected"{/if}>{l s='In stock'}</option>*}
                {/if}
            </select>
        </div>
    </form>
    <!-- /Sort products -->
    {if !isset($paginationId) || $paginationId == ''}
        {addJsDef request=$request}
    {/if}
{/if}
