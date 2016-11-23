<div class="col-xs-12 col-sm-12">
    {capture name=path}{l s='Home'}{/capture}
    <div class="page-header">
        <div>
            <h2>{if $cookie->customer_firstname != ''}
                    {l s='Hi, %s !' sprintf=$cookie->customer_firstname}
                {else}
                    {l s='Hi!' sprintf=$cookie->customer_firstname}
                {/if}
            </h2>
        </div>
        {include file="{$tpl_dir}mobile/my-account-add-address.tpl"}
        <div class="clearfix"></div>
    </div>
    {if isset($account_created)}
        <p class="alert alert-success">
            {l s='Your account has been created.'}
        </p>
    {/if}
    <div class="my-account-content-block">
        <div class="addresses-lists">
            <div class="myaccount-link-list row gutter-10">
                <div class="col-xs-6">
                    <a href="{$link->getPageLink('identity', true)|escape:'html':'UTF-8'}">
                        <span>{l s='Mes informations personnelles / Newsletter'}</span>
                        <img src="{$img_dir}ESPC-Accueil-Newsletters.jpg" />
                    </a>
                </div>
                <div class="col-xs-6">
                    <a href="{$link->getPageLink('addresses', true)|escape:'html':'UTF-8'}">
                        <span>{l s='Add a delivery/billing address'}</span>
                        <img src="{$img_dir}ESPC-Accueil-Adresse.jpg" />
                    </a>
                </div>

                <div class="col-xs-6">
                    <a href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}">
                        <span>{l s='Follow my last order'}</span>
                        <img src="{$img_dir}ESPC-Accueil-Suivi.jpg" />
                    </a>
                </div>
                <div class="col-xs-6">
                    <a href="{$link->getPageLink('order-follow', true)|escape:'html':'UTF-8'}">
                        <span>{l s='Return a product'}</span>
                        <img src="{$img_dir}ESPC-Accueil-Retour.jpg" />
                    </a>
                </div>
                <div class="col-xs-6">
                    <a href="{$link->getModuleLink('blockwishlist', 'mywishlist', array(), true)|escape:'html':'UTF-8'}">
                        <span>{l s='See my wishlist'}</span>
                        <img src="{$img_dir}ESPC-Accueil-Favoris.jpg" />
                    </a>
                </div>
                <div class="col-xs-6">
                    <a href="{$link->getPageLink('contact', true)|escape:'html':'UTF-8'}">
                        <span>{l s='Contact the customer service'}</span>
                        <img src="{$img_dir}ESPC-Accueil-ServiceClient.jpg" />
                    </a>
                </div>

                {* Fidelité + Parrainage *}
                {*$HOOK_CUSTOMER_ACCOUNT*}
            </div>
        </div>
    </div>
</div>