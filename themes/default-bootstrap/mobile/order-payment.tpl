{addJsDefL name=txtProduct}{l s='product' js=1}{/addJsDefL}
{addJsDefL name=txtProducts}{l s='products' js=1}{/addJsDefL}
{capture name=path}{l s='Your payment method'}{/capture}
{*if !isset($empty) && !$PS_CATALOG_MODE}
    <span class="heading-counter">{l s='Your shopping cart contains:'}
        <span id="summary_products_quantity">{$productNumber} {if $productNumber == 1}{l s='product'}{else}{l s='products'}{/if}</span>
			</span>
{/if*}

{assign var='current_step' value='payment'}

<div id="order_payment_tabs">
    <div class="row gutter-10">
        <div class="col-xs-6 col-sm-6 valign-middle tabActive">
            <div data-payment="payment_credit_card" class="btn btn-primary btn-block">
                <span class="icon-credit-card icon-white"></span> {l s='Credit Card'}
            </div>
        </div>
        <div class="col-xs-6 col-sm-6 valign-middle tabInactive">
            <div data-payment="payment_paypal" class="btn btn-default btn-block">
                <span class="icon-paypal icon-white"></span> {l s='Paypal'}
            </div>
        </div>
    </div>
    
    {$HOOK_PAYMENT}
</div>
<div class="text-right order_cgv">
    <small><em>{l s='En validant votre commande, vous acceptez l\'intégralité de nos'} <a href="/nous-connaitre/17-conditions-generales-de-ventes" target="_blank">{l s='Conditions générales de vente'}</a> {l s='ainsi que notre'} <a href="/nous-connaitre/15-politique-confidentialite" target="_blank">{l s='politique de gestion de vos informations personnelles'}</a>.
    </em></small>
</div>