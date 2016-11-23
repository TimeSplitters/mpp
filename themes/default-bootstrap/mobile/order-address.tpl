{assign var="back_order_page" value="order-opc.php"}
<div id="opc_account-overlay" class="opc-overlay" style="display: none;">
</div>
<div class="addresses">
    <div id="create_account_block">

        <div class="table" id="login_create_table">
            <div class="table-row">
                <div class="table-cell" colspan="2">
                    {if !$logged}
                        {include file="$tpl_dir./mobile/order-registration-form.tpl"}
                    {/if}
                </div>
            </div>
        </div>
        <div class="table{if !$logged} hidden{/if}" id="addresses_table">
            <div>
                <div id="delivery_address_fieldset">
                    {include file="$tpl_dir./mobile/order-delivery-address-form.tpl"}
                </div>
                <div id="billing_address_fieldset">
                    {include file="$tpl_dir./mobile/order-billing-address-form.tpl"}
                </div>
            </div>
        </div>
    </div>
    <div class="order_continue_button form-group">
        <input type="hidden" class="hidden" name="step" value="2"/>
        <input type="hidden" name="back" value="{$back}"/>

        <button name="processAddress" id="processAddress" class="order_block_continue_button btn btn-default btn-block">
            <span>{l s='Continue'}</span>
        </button>
    </div>
</div> <!-- end addresses -->


{strip}
    {if !$opc}
        {addJsDef orderProcess='order'}
        {addJsDefL name=txtProduct}{l s='product' js=1}{/addJsDefL}
        {addJsDefL name=txtProducts}{l s='products' js=1}{/addJsDefL}
        {addJsDefL name=CloseTxt}{l s='Submit' js=1}{/addJsDefL}
    {/if}
    {capture}{if $back}&mod={$back|urlencode}{/if}{/capture}
    {capture name=addressUrl}{$link->getPageLink('address', true, NULL, 'back='|cat:$back_order_page|cat:'?step=1'|cat:$smarty.capture.default)|escape:'quotes':'UTF-8'}{/capture}
    {addJsDef addressUrl=$smarty.capture.addressUrl}
    {capture}{'&multi-shipping=1'|urlencode}{/capture}
    {addJsDef addressMultishippingUrl=$smarty.capture.addressUrl|cat:$smarty.capture.default}
    {capture name=addressUrlAdd}{$smarty.capture.addressUrl|cat:'&id_address='}{/capture}
    {addJsDef addressUrlAdd=$smarty.capture.addressUrlAdd}
    {addJsDef formatedAddressFieldsValuesList=$formatedAddressFieldsValuesList}
    {addJsDef opc=$opc|boolval}
    {capture}<h3 class="page-subheading">{l s='Your billing address' js=1}</h3>{/capture}
    {addJsDefL name=titleInvoice}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
    {capture}<h3 class="page-subheading">{l s='Your delivery address' js=1}</h3>{/capture}
    {addJsDefL name=titleDelivery}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
    {capture}<a class="button button-small btn btn-default" href="{$smarty.capture.addressUrlAdd}"
                title="{l s='Update' js=1}"><span>{l s='Update' js=1}<i class="icon-chevron-right right"></i></span>
        </a>{/capture}
    {addJsDefL name=liUpdate}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
{/strip}