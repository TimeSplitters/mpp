<div class="col-xs-12 col-sm-12">
    {capture name=path}
        <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">
            {l s='My account'}
        </a>
        <span class="navigation-pipe">{$navigationPipe}</span>
        <span class="navigation_page">{l s='Order history'}</span>
    {/capture}
    {include file="$tpl_dir./errors.tpl"}
    {if $slowValidation}
        <p class="alert alert-warning">{l s='If you have just placed an order, it may take a few minutes for it to be validated. Please refresh this page if your order is missing.'}</p>
    {/if}
    <div class="page-header">
        <div>
            {include file="{$tpl_dir}mobile/espace_client_sublinks.tpl" titleAccordion={l s='Mes commandes'}}
        </div>
        {include file="{$tpl_dir}mobile/my-account-add-address.tpl"}
        <div class="clearfix"></div>
    </div>
    <div>
        <div>
            <!-- main col -->
            <div class="block-center" id="block-history">
                {if $currents && count($currents)}
                <div id="order-list" class="table">
                    <h5 class="page-subheading">{l s='Currents orders'}</h5>
                    {assign var="reference" value=""}
                    {foreach from=$currents item=order name=myLoop}
                        <div class="{if $smarty.foreach.myLoop.first}first_item{elseif $smarty.foreach.myLoop.last}last_item{else}item{/if} {if $smarty.foreach.myLoop.index % 2}alternate_item{/if} {if $reference==$order.reference}noborder{/if} clickable-row"
                             data-href="{$link->getPageLink('order-detail', true)|escape:'html':'UTF-8'}?id_order={$order.id_order}&reference={$order.reference}">

                            <div class="row gutter-10">
                                <em data-value="{$order.date_add|regex_replace:"/[\-\:\ ]/":""}"
                                    class="history_date bold col-xs-6">
                                    {if $reference!=$order.reference}
                                        {$order.date_add|date_format:"%d.%m.%Y"}
                                    {/if}
                                </em>
                                <div class="history_link text-right col-xs-6">
                                    Ref. {Order::getUniqReferenceOf($order.id_order)}
                                </div>
                            </div>

                            <div class="history_price row gutter-10" data-value="{$order.total_paid}">
                                <div class="col-xs-4">
                                    <strong>{l s='Montant'}</strong>
                                </div>
                                <div class="col-xs-8">
								<span class="price">
									{displayPrice price=$order.total_paid currency=$order.id_currency no_utf8=false convert=false}
								</span>
                                </div>
                            </div>
                            <div class="history_quantity row gutter-10">
                                <div class="col-xs-4">
                                    <strong>{l s='Nbr. produits'}</strong>
                                </div>
                                <div class="col-xs-8">
                                    {$order.nb_products}
                                </div>
                            </div>
                            <div{if isset($order.order_state)} data-value="{$order.id_order_state}"{/if}
                                    class="history_state row gutter-10">
                                <div class="col-xs-4">
                                    <strong>{l s='État'}</strong>
                                </div>
                                <div class="col-xs-8">
                                    {if isset($order.order_state)}
                                        <span>
									{$order.order_state|escape:'html':'UTF-8'}
								</span>
                                    {/if}
                                </div>
                            </div>
                        </div>
                        {if $reference!=$order.reference}
                            {assign var="reference" value=$order.reference}
                        {/if}

                    {/foreach}
                </div>
                <div id="block-order-detail" class="unvisible">&nbsp;</div>
                {else}
                <p class="text-center">{l s='You have not placed any orders.'}
                <p class="text-center"><a href="/61-tous-nos-articles" class="btn btn-default">Poursuivre mes achats</a>
                    {/if}
            </div>
            <div class="block-center" id="block-history">
                {if $history && count($history)}
                    <table id="order-list" class="table">
                        <caption>{l s='Your Order history'}</caption>
                        <thead>
                        <tr>
                            <th class="item">{l s='Date'}</th>
                            <th class="first_item" data-sort-ignore="true">{l s='Order number'}</th>
                            <th data-hide="phone" class="item">{l s='Amount'}</th>
                            <th data-sort-ignore="true" data-hide="phone,tablet"
                                class="item  text-center">{l s='Nbr Produits'}</th>
                            <th class="last_item">{l s='Status'}</th>

                        </tr>
                        </thead>
                        <tbody>
                        {foreach from=$history item=order name=myLoop}
                            <tr class="{if $smarty.foreach.myLoop.first}first_item{elseif $smarty.foreach.myLoop.last}last_item{else}item{/if} {if $smarty.foreach.myLoop.index % 2}alternate_item{/if} {if $reference!=$order.reference}noborder{/if} clickable-row"
                                data-href="{$link->getPageLink('order-detail', true)|escape:'html':'UTF-8'}?id_order={$order.id_order}&reference={$order.reference}">
                                <td data-value="{$order.date_add|regex_replace:"/[\-\:\ ]/":""}"
                                    class="history_date bold">
                                    {$order.date_add|date_format:"%d.%m.%Y"}
                                </td>
                                <td class="history_link">
                                    {Order::getUniqReferenceOf($order.id_order)}
                                </td>
                                <td class="history_price" data-value="{$order.total_paid}">
							<span class="price">
								{displayPrice price=$order.total_paid currency=$order.id_currency no_utf8=false convert=false}
							</span>
                                </td>
                                <td class="history_quantity  text-center">{$order.nb_products}</td>
                                <td{if isset($order.order_state)} data-value="{$order.id_order_state}"{/if}
                                        class="history_state">
                                    {if isset($order.order_state)}
                                        <span>
									{$order.order_state|escape:'html':'UTF-8'}
								</span>
                                    {/if}
                                </td>

                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                {/if}
            </div>
            <!-- end main col -->
        </div>

    </div>
</div>