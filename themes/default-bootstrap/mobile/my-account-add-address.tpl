{if $customer_has_address == false}
    <div class="alert alert-info">
        <a href="{$link->getPageLink('addresses', true)|escape:'html':'UTF-8'}"><span>{l s='To save time, complete your information!'}</span></a>
    </div>
{/if}