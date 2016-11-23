<div id="select_product_shipping">
    <form id="form"
          action="{$link->getPageLink('order', true, NULL, "{if $multi_shipping}multi-shipping={$multi_shipping}{/if}")|escape:'html':'UTF-8'}"
          method="post" name="carrier_area">
        {assign var='have_non_virtual_products' value=false}
        {foreach $products_delays as $delays => $d_products}
            <div>
                <h3 class="text-uppercase"><span class="icon-bolt icon-l"></span> {if $delays != '0'}{l s='Delivery within'} {$delays} {l s='weeks'}{else}{l s='Express delivery'} : {l s='5-8 days'}{/if}</h3>

                <div>
                    {foreach $d_products as $product}
                        <div class="row gutter-10">
                            {if $product.is_virtual == 0}
                                {assign var='have_non_virtual_products' value=true}
                            {/if}
                            {assign var='productId' value=$product.id_product}
                            {assign var='productAttributeId' value=$product.id_product_attribute}
                            {assign var='quantityDisplayed' value=0}
                            <div class="col-xs-4 cart_product">
                                <span class="cart_product_quantity">{$product.cart_quantity}</span>
                                <img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}"
                                     alt="{$product.name|escape:'html':'UTF-8'}"
                                class="btn-block" />
                            </div>
                            <div class="col-xs-8">
                                <div class="cart_description">
                                    {capture name=sep} : {/capture}
                                    {capture}{l s=' : '}{/capture}
                                    <strong class="text-uppercase product-name">{$product.name|escape:'html':'UTF-8'}</strong>
                                    {if isset($product.attributes) && $product.attributes}
                                        <small>{$product.categoryName}</small>
                                    {/if}
                                </div>
                                <div class="cart_product_shipping">
                                    <div class="table">
                                        {assign var=del_i value=0}
                                        {assign var=delivery_options_selected value=$products_carriers}
                                        {foreach $product_carriers[$product.id_product_attribute] as $delivery_list}
                                            <div class="table-row{if $product_carriers[$product.id_product_attribute]|@count == 1 || $delivery_options_selected[$product.id_product_attribute] == $delivery_list['id_delivery']} select_delivery_option{/if}">
                                                <div class="table-cell">
                                                    <input id="delivery_option_{$product.id_product_attribute}_{$delivery_list['id_delivery']}" class="delivery_option_radio" type="radio" name="delivery_option[{$product.id_product_attribute}]" value="{$delivery_list['id_delivery']}" data-product-id="{$product.id_product_attribute}" {if $product_carriers[$product.id_product_attribute]|@count == 1 || $delivery_options_selected[$product.id_product_attribute] == $delivery_list['id_delivery'] || ($product_carriers[$product.id_product_attribute]|@count >= 2 && $del_i == ($product_carriers[$product.id_product_attribute]|@count -1))}checked{/if} />
                                                    <label for="delivery_option_{$product.id_product_attribute}_{$delivery_list['id_delivery']}">
                                                        <span></span>
                                                        {if Product::getRealQuantity($product.id_product, $product.id_product_attribute) >= $product.cart_quantity}
                                                            <strong class="text-uppercase">{$delivery_list['carrier']->label} - Express</strong>
                                                        {else}
                                                            <strong class="text-uppercase">{$delivery_list['carrier']->label}</strong>
                                                        {/if}
                                                        {$delivery_list['price']}
                                                        <br />
                                                        <small>{$delivery_list['carrier']->label_livraison} </small>
                                                    </label>
                                                </div>
                                                <div class="table-cell">
                                                    {$delivery_values[$delivery_list['id_delivery']] =$delivery_list['price']}
                                                    {$product_quantity[$product.id_product_attribute] =$product.cart_quantity}
                                                </div>
                                            </div>
                                            {assign var=del_i value=$del_i+1}
                                        {/foreach}
                                    </div>
                                </div>
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        {/foreach}
        <div class="general_error error_message"></div>
    </form>

    <div class="order_continue_button">
        <button name="continue_shipping_button" id="continue_shipping_button" class="order_block_continue_button btn btn-default btn-block">
            <span>{l s='Continue'}</span>
        </button>
    </div>
</div>
{strip}
    {addJsDef delivery_vals=$delivery_values}
    {addJsDef product_qty=$product_quantity}
{/strip}