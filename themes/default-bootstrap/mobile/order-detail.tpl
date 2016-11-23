<div class="col-xs-12 col-sm-12">
    {capture name=path}
        <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">
            {l s='My account'}
        </a>
        <span class="navigation-pipe">
		{$navigationPipe}
	</span>
        <a href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}">
            {l s='Order history'}
        </a>
        <span class="navigation-pipe">
		{$navigationPipe}
	</span>
        <span class="navigation_page">
		{l s='My order'}
	</span>
    {/capture}
    <div class="page-header">
        <div>
            {include file="{$tpl_dir}mobile/espace_client_sublinks.tpl" titleAccordion={l s='Mes commandes'}}
        </div>
        {include file="{$tpl_dir}mobile/my-account-add-address.tpl"}
        <div class="clearfix"></div>
    </div>
    <div>
        <div>
            <div>
                {assign var='cpt_order' value=0}
                {assign var='old_status' value=-1}
                {assign var='pricewithouttaxes' value=0}
                {assign var='pricewithtaxes'  value=0}
                {assign var='discount' value=0}
                {assign var='$total_wrapping' value=0}
                {assign var='total_shipping' value=0}
                {assign var='total_paid' value=0}
                {assign var='total_wrapping' value=0}
                {if isset($orders)}

                {foreach from=$orders name=id_order item=order}

                    {assign var='carriers' value=$order['order']->getShipping()}
                    {assign var='id_status' value=$order['order_state']}
                    {if $id_status==9}
                        {assign var='id_status' value=2}
                    {/if}

                    {if $cpt_order==0}
                        <h5 class="page-subheading">
                            {l s='Ordered on'} {$order['order']->date_add|date_format:"%d.%m.%Y"}
                            [#{$order['order']->reference}]
                            {if $order.invoice}
                                <a href="{$link->getPageLink('pdf-invoice', true)}&submitAction=generateInvoicePDF&id_order_invoice={$order['order']->invoice_number|intval}{if is_guest}&reference={$order['order']->reference}&secure_key={$order['order']->secure_key|escape:'html':'UTF-8'}{/if}">{l s='Download your invoice.'}</a>
                            {/if}
                        </h5>
                        {assign var='cpt_order' value=1}
                    {/if}
                    <div class="table col-xs-12 order-detail">
                        <div class="caption-light">
                            <div class="pull-xs-right">
                                <a href="#" class="delivery_infos">{l s='Delivery information'} <span class="icon-plus"></span><span class="icon-minus hidden"></span> </a></div>
                            <div>{include file="$tpl_dir/mobile/order-status-progress.tpl" current=$id_status instock=$order['instock']}</div>
                        </div>
                        <div class="collapse row gutter-10">
                            <div>
                                <div>
                                    <h6 class="text-uppercase">{l s='Contact'}</h6>
                                    <blockquote>{$customer_adresses} {$customer->phone}<br/>{$customer->email}
                                    </blockquote>
                                </div>
                                <div>
                                    <h6 class="text-uppercase">{l s='Livraison'}</h6>
                                    <blockquote>
                                        {foreach from=$dlv_adr_fields name=dlv_loop item=field_item}
                                            {if $field_item eq "company" && isset($address_delivery->company)}
                                                <div class="address_company">{$address_delivery->company|escape:'html':'UTF-8'}</div>
                                            {elseif $field_item eq "address2" && $address_delivery->address2}
                                                <div class="address_address2">{$address_delivery->address2|escape:'html':'UTF-8'}</div>
                                            {elseif $field_item eq "phone_mobile" && $address_delivery->phone_mobile}
                                                <div class="address_phone_mobile">{$address_delivery->phone_mobile|escape:'html':'UTF-8'}</div>
                                            {else}
                                                {assign var=address_words value=" "|explode:$field_item}
                                                <div>{foreach from=$address_words item=word_item name="word_loop"}{if !$smarty.foreach.word_loop.first} {/if}
                                                        <span
                                                        class="address_{$word_item|replace:',':''}">{$deliveryAddressFormatedValues[$word_item|replace:',':'']|escape:'html':'UTF-8'}</span>{/foreach}
                                                </div>
                                            {/if}
                                        {/foreach}
                                    </blockquote>
                                </div>
                                <div>
                                    <h6 class="text-uppercase">{l s='Transporteur'}</h6>
                                    <blockquote>
                                        {foreach from=$carriers item=line}
                                            <div class="row">
                                                <div>{$line.carrier_name}</div>
                                                <div>
                                                    <span class="shipping_number_show">{if $line.tracking_number}{if $line.url && $line.tracking_number}
                                                            <strong>{l s='Tracking number'}</strong>
                                                            <br/>
                                                            <a
                                                            href="{$line.url|replace:'@':$line.tracking_number}">{$line.tracking_number}</a>{else}{$line.tracking_number}{/if}{else}{/if}</span>
                                                </div>
                                            </div>
                                        {/foreach}
                                        {if $order['instock'] }
                                            {$order['carrier']->delay|replace:'standard':'express'}
                                        {else}
                                            {$order['carrier']->delay}
                                        {/if}
                                    </blockquote>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="table col-xs-12">
                        <div>
                            {foreach from=$order['products'] item=product name=products}

                                {if !isset($product.deleted)}

                                    {assign var='productId' value=$product.product_id}

                                    {assign var='productAttributeId' value=$product.product_attribute_id}
                                    {if isset($product.customizedDatas)}
                                        {assign var='productQuantity' value=$product.product_quantity-$product.customizationQuantityTotal}
                                    {else}
                                        {assign var='productQuantity' value=$product.product_quantity}
                                    {/if}
                                    <!-- Classic products -->
                                    {if $product.product_quantity > $product.customizationQuantityTotal}
                                        <div class="item active">
                                            <div class="row gutter-10">
                                                <div class="col-xs-12 col-sm-6">
                                                    {assign var='image' value=$product.image}
                                                    {if isset($image) }
                                                        {assign var=imageId value="`$product.id_product`-`$image->id_image`"}
                                                        <a href="{$product.url}">
                                                            <img class="thumb_cart"
                                                                 src="{$link->getImageLink($product.link_rewrite, $imageId, 'home_default')|escape:'html'}"
                                                                 alt="{$image->legend[0]|htmlspecialchars}"
                                                                 rel="{$link->getImageLink($product->link_rewrite, $imageId, 'home_default')}"/>
                                                        </a>
                                                    {/if}
                                                </div>
                                                <div class="name col-xs-12 col-sm-6">
                                                    <label for="cb_{$product.id_order_detail|intval}">
                                                        <strong>{$product['product_name']|escape:'html':'UTF-8'|replace:' - ':'<br/>'} x{$productQuantity|intval}</strong>
                                                        <br/>
                                                        {$product['category']}
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="price row gutter-10 text-right text-uppercase">
                                                <div class="col-xs-8">
                                                    <strong>{l s='Prix unitaire'}</strong>
                                                </div>
                                                <div class="col-xs-4">
                                                {if $group_use_tax}
                                                    {convertPriceWithCurrency price=$product.unit_price_tax_incl currency=$currency}
                                                {else}
                                                    {convertPriceWithCurrency price=$product.unit_price_tax_excl currency=$currency}
                                                {/if}
                                                </div>
                                            </div>
                                            <div class="price row gutter-10 text-right text-uppercase">
                                                <div class="col-xs-8">
                                                    <strong>{l s='Prix total'}</strong>
                                                </div>
                                                <div class="col-xs-4">
                                                {if $group_use_tax}
                                                    {convertPriceWithCurrency price=$product.total_price_tax_incl currency=$currency}
                                                {else}
                                                    {convertPriceWithCurrency price=$product.total_price_tax_excl currency=$currency}
                                                {/if}
                                                </div>
                                            </div>
                                        </div>
                                    {/if}
                                {/if}
                            {/foreach}
                            {$pricewithouttaxes=$pricewithouttaxes+$order['order']->getTotalProductsWithoutTaxes()}
                            {$pricewithtaxes=$pricewithtaxes+$order['order']->getTotalProductsWithTaxes()}
                            {$discount=$discount+$order['order']->total_discounts_tax_incl}
                            {$total_wrapping=$total_wrapping+$order['order']->total_wrapping}
                            {$total_shipping=$total_shipping+$order['order']->total_shipping}
                            {$total_paid=$total_paid+$order['order']->total_paid}
                            {$currency=$order['currency']}
                        </div>
                    </div>
                {/foreach}
                <div class="row total-orders text-right">
                    <div class="col-xs-12">
                        <div class="item">
                            <div class="row gutter-10">
                                <div class="col-xs-8 text-uppercase"><strong>{l s='Sub-total'}</strong></div>
                                <div class="col-xs-4">{displayWtPriceWithCurrency price=$pricewithtaxes currency=$currency}</div>
                            </div>
                            {if $discount > 0}
                            <div class="row gutter-10">
                                <div class="col-xs-8 text-uppercase text-success"><strong>{l s='Total vouchers'}</strong></div>
                                <div class="col-xs-4 text-success">
                                    - {displayWtPriceWithCurrency price=$discount currency=$currency}</div>
                            </div>
                            {/if}
                            <div class="row gutter-10">
                                <div class="col-xs-8 text-uppercase"><strong>{l s='Shipping fees'}</strong></div>
                                <div class="col-xs-4">{displayWtPriceWithCurrency price=$total_shipping currency=$currency}
                                </div>
                            </div>
                            <div class="totalprice row gutter-10">
                                <div class="col-xs-8 text-uppercase"><strong>{l s='Total'}</strong></div>
                                <div class="col-xs-4">{displayWtPriceWithCurrency price=$total_paid currency=$currency}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <a href="/index.php?controller=order-follow" class="btn btn-default btn-block">{l s='Retourner des articles'}</a>
            </div>
        </div>
    </div>
    {/if}
</div>