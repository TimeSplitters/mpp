<div class="col-xs-12 col-sm-12">
    {capture name=path}<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">{l s='My account'}</a>
    <span class="navigation-pipe">{$navigationPipe}</span>
    <span class="navigation_page">{l s='My addresses'}</span>{/capture}

<div class="page-header">
    <div>
        {include file="{$tpl_dir}mobile/espace_client_sublinks.tpl" titleAccordion={l s='Mes adresses'}}
    </div>
    {include file="{$tpl_dir}mobile/my-account-add-address.tpl"}
    <div class="clearfix"></div>
</div>
<div class="my-account-content-block">
    <div id="my-account-identity-tabs" class="usual">
        <div id="tab-identity"></div>
        <div id="tab-addresses">
            {if isset($multipleAddresses) && $multipleAddresses}
                <div class="addresses">
                    {assign var="adrs_style" value=$addresses_style}
                    <div class="bloc_adresses">
                        {foreach from=$multipleAddresses|@array_reverse item=address name=myLoop}
                        <div class="address identity-info-blocks">
                            <h5 class="page-subheading">
                                <div class="address_update pull-xs-right">
                                    <a href="{$link->getPageLink('address', true, null, "id_address={$address.object.id|intval}")|escape:'html':'UTF-8'}">
                                        <span class="icon-pencil"></span>
                                    </a>
                                </div>
                            {if $address.object.alias != ""}
                                {$address.object.alias}
                            {else}
                                {l s='Default address'}
                            {/if}</h5>
                            <blockquote class="{if $smarty.foreach.myLoop.last}last_item{elseif $smarty.foreach.myLoop.first}first_item{/if}{if $smarty.foreach.myLoop.index % 2} alternate_item{else} item{/if} box">
                                {foreach from=$address.ordered name=adr_loop item=pattern}
                                    {assign var=addressKey value=" "|explode:$pattern}
                                        {foreach from=$addressKey item=key name="word_loop"}
                                            {if $address.formated[$key|replace:',':''] != ""}<span {if isset($addresses_style[$key])} class="{$addresses_style[$key]}"{/if}>
                            {$address.formated[$key|replace:',':'']|escape:'html':'UTF-8'}
                                        </span>
                                            <br />
                                            {/if}
                                        {/foreach}
                                {/foreach}
                            </blockquote>
                        </div>
                        {if $smarty.foreach.myLoop.index % 2 && !$smarty.foreach.myLoop.last}
                    </div>
                    <div class="bloc_adresses">
                        {/if}
                        {/foreach}
                    </div>
                </div>
            {else}
                <p class="text-center">{l s='Yet you have not specified a delivery address and a billing address.'}
                </p>
            {/if}
            <div class="clearfix text-center">
                <br />
                <a href="{$link->getPageLink('address', true)|escape:'html':'UTF-8'}" title="{l s='Add an address'}" data-fancybox-type="iframe" id="add_address"
                   class="btn btn-default btn-block">
                    <span>{l s='Add a new address'}</span>
                </a>
            </div>
            {addJsDefL name=addressesConfirm}{l s='Are you sure?' js=1}{/addJsDefL}
        </div>
        <div id="tab-newsletter"></div>
    </div>
</div>
</div>