<div id="product_{$product.id_product}_{$product.id_product_attribute}_{if $quantityDisplayed > 0}nocustom{else}0{/if}_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}"
     class="row gutter-10 cart_item{if isset($productLast) && $productLast && (!isset($ignoreProductLast) || !$ignoreProductLast)} last_item{/if}{if isset($productFirst) && $productFirst} first_item{/if}{if isset($customizedDatas.$productId.$productAttributeId) AND $quantityDisplayed == 0} alternate_item{/if} address_{$product.id_address_delivery|intval}">
    <div class="cart_product col-xs-4 col-sm-4">
        <img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}"
             alt="{$product.name|escape:'html':'UTF-8'}"
             class="btn-block"/>
    </div>
    <div class="cart_description col-xs-8 col-sm-8">
        <span class="pull-xs-right">
            <a rel="nofollow" class="cart_quantity_delete"
               id="{$product.id_product}_{$product.id_product_attribute}_{if $quantityDisplayed > 0}nocustom{else}0{/if}_{$product.id_address_delivery|intval}"
               href="{$link->getPageLink('cart', true, NULL, "delete=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_address_delivery={$product.id_address_delivery|intval}&amp;token={$token_cart}")|escape:'html':'UTF-8'}">
                <span class="icon-times icon-light"></span>
            </a>
        </span>
        {capture name=sep} : {/capture}
        {capture}{l s=' : '}{/capture}
        <strong class="product-name text-uppercase">{$product.name|escape:'html':'UTF-8'}</strong>
        <br/>
        {if isset($product.attributes) && $product.attributes}
            {$product.categoryName}, {$product.attributes|@replace: $smarty.capture.sep:$smarty.capture.default|escape:'html':'UTF-8'}
        {/if}
        <br/>
        <div class="delivery_block" rel="{$product.id_product_attribute}">
            <span class="express_delivery_block valign-middle{if Product::getRealQuantity($product.id_product, $product.id_product_attribute) < $product.cart_quantity} hidden{/if}" data-toggle="tooltip" data-placement="bottom"
                   title="{l s='We love this product, that\'s why we have a limited stock. Order now to enjoy an express delivery within a week!'}">
                {l s='Express delivery'}
                <span class="icon-question icon-light"></span>
            </span>
            <span class="no_express_delivery_block valign-middle{if Product::getRealQuantity($product.id_product, $product.id_product_attribute) >= $product.cart_quantity} hidden{/if}" data-toggle="tooltip" data-placement="bottom"
                   title="{l s='Our products are manufactured on demand in order to offer you the best prices. Delays might seem long, but we promise: your patience will be rewarded!'}">
                {l s='Delivery from'} {$product.delay_min} {l s='Delivery to'} {$product.delay_max} {l s='weeks'}
                <span class="icon-question icon-light"></span>
            </span>
        </div>
        {if !$product.is_virtual}{hook h="displayProductDeliveryTime" product=$product}{/if}
        <br/>
        {*if !isset($noDeleteButton) || !$noDeleteButton}
            {if (!isset($customizedDatas.$productId.$productAttributeId) OR $quantityDisplayed > 0) && empty($product.gift)}
            <small>
                <a rel="nofollow" class="cart_quantity_delete"
                   id="{$product.id_product}_{$product.id_product_attribute}_{if $quantityDisplayed > 0}nocustom{else}0{/if}_{$product.id_address_delivery|intval}"
                   href="{$link->getPageLink('cart', true, NULL, "delete=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_address_delivery={$product.id_address_delivery|intval}&amp;token={$token_cart}")|escape:'html':'UTF-8'}">{l s='Delete'}</a>
            </small>
            {/if}
        {/if*}
        <div class="row gutter-10 valign-middle">
            <div class="cart_quantity col-xs-6 col-sm-6">
                {if (isset($cannotModify) && $cannotModify == 1)}
                    <span>
                    {if $quantityDisplayed == 0 AND isset($customizedDatas.$productId.$productAttributeId)}
                        {$product.customizationQuantityTotal}
                    {else}
                        {$product.cart_quantity-$quantityDisplayed}
                    {/if}
                </span>
                {else}
                    {if isset($customizedDatas.$productId.$productAttributeId) AND $quantityDisplayed == 0}
                        <span id="cart_quantity_custom_{$product.id_product}_{$product.id_product_attribute}_{$product.id_address_delivery|intval}">{$product.customizationQuantityTotal}</span>
                    {/if}
                    {if !isset($customizedDatas.$productId.$productAttributeId) OR $quantityDisplayed > 0}
                        <div class="cart_quantity_button clearfix">
                            {if $product.minimal_quantity < ($product.cart_quantity-$quantityDisplayed) OR $product.minimal_quantity <= 1}
                                <a rel="nofollow" class="cart_quantity_down"
                                   id="cart_quantity_down_{$product.id_product}_{$product.id_product_attribute}_{if $quantityDisplayed > 0}nocustom{else}0{/if}_{$product.id_address_delivery|intval}"
                                   href="{$link->getPageLink('cart', true, NULL, "add=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_address_delivery={$product.id_address_delivery|intval}&amp;op=down&amp;token={$token_cart}")|escape:'html':'UTF-8'}">
                                    <span class="icon-caret-down minus-quantity icon-l icon-light"></span>
                                </a>
                            {else}
                                <a class="cart_quantity_down disabled" href="#"
                                   id="cart_quantity_down_{$product.id_product}_{$product.id_product_attribute}_{if $quantityDisplayed > 0}nocustom{else}0{/if}_{$product.id_address_delivery|intval}"
                                   title="{l s='You must purchase a minimum of %d of this product.' sprintf=$product.minimal_quantity}">
                                    <span class="icon-caret-down minus-quantity icon-l icon-light"></span>
                                </a>
                            {/if}
                            <input type="hidden"
                                   value="{if $quantityDisplayed == 0 AND isset($customizedDatas.$productId.$productAttributeId)}{$customizedDatas.$productId.$productAttributeId|@count}{else}{$product.cart_quantity-$quantityDisplayed}{/if}"
                                   name="quantity_{$product.id_product}_{$product.id_product_attribute}_{if $quantityDisplayed > 0}nocustom{else}0{/if}_{$product.id_address_delivery|intval}_hidden"/>
                            <input size="2" type="text" autocomplete="off" class="cart_quantity_input grey"
                                   value="{if $quantityDisplayed == 0 AND isset($customizedDatas.$productId.$productAttributeId)}{$customizedDatas.$productId.$productAttributeId|@count}{else}{$product.cart_quantity-$quantityDisplayed}{/if}"
                                   name="quantity_{$product.id_product}_{$product.id_product_attribute}_{if $quantityDisplayed > 0}nocustom{else}0{/if}_{$product.id_address_delivery|intval}"/>
                            <a rel="nofollow" class="cart_quantity_up"
                               id="cart_quantity_up_{$product.id_product}_{$product.id_product_attribute}_{if $quantityDisplayed > 0}nocustom{else}0{/if}_{$product.id_address_delivery|intval}"
                               href="{$link->getPageLink('cart', true, NULL, "add=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_address_delivery={$product.id_address_delivery|intval}&amp;token={$token_cart}")|escape:'html':'UTF-8'}">
                                <span class="icon-caret-up plus-quantity icon-l icon-light"></span>
                            </a>
                        </div>
                    {/if}
                {/if}
            </div>
            <div class="cart_total col-xs-6 col-sm-6 text-right">
                <span class="price_without_reduction strikethrough"
                      id="price_without_reduction_{$product.id_product}_{$product.id_product_attribute}{if $quantityDisplayed > 0}_nocustom{/if}_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}">{if $product.price_without_reduction != $product.price_with_reduction}{displayPrice price=($product.price_without_reduction*$product.cart_quantity)}{/if}</span>
                <span class="price{if $product.price_without_reduction != $product.price_with_reduction} price_reduced{/if}"
                      id="total_product_price_{$product.id_product}_{$product.id_product_attribute}{if $quantityDisplayed > 0}_nocustom{/if}_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}">
                {if !empty($product.gift)}
                    <span class="gift-icon">{l s='Gift!'}</span>
                {else}
                    {if $quantityDisplayed == 0 AND isset($customizedDatas.$productId.$productAttributeId)}
                        {if !$priceDisplay}{displayPrice price=$product.total_customization_wt}{else}{displayPrice price=$product.total_customization}{/if}
                    {else}
                        {if !$priceDisplay}
                            {displayPrice price=$product.total_wt}
                        {else}
                            {displayPrice price=$product.total}
                        {/if}
                    {/if}
                {/if}
		        </span>
            </div>
        </div>
    </div>
</div>
