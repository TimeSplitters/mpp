<div id="header_user" class="{if $PS_CATALOG_MODE} header_user_catalog"{/if}">
    <div id="header_user_info">
        {if $logged}
                <span class="icon-user"></span> {l s='Welcome' mod='blockuserinfo'} <a href="{$link->getPageLink('my-account', true)|escape:'html'}" title="{l s='View my customer account' mod='blockuserinfo'}" class="account" rel="nofollow"><span>{$cookie->customer_firstname} {$cookie->customer_lastname}</span></a>
        {else}
            <a href="{$link->getPageLink('my-account', true)|escape:'html'}" title="{l s='Log in to your customer account' mod='blockuserinfo'}" class="login" rel="nofollow">{l s='Sign in' mod='blockuserinfo'}</a>
        {/if}

        <ul id="header_nav" class="hidden">
            {if $logged}
                <li id="your_account">
                    <a href="{$link->getPageLink('my-account', true)|escape:'html'}" title="{l s='View my customer account' mod='blockuserinfo'}" rel="nofollow">{l s='Your Account' mod='blockuserinfo'}</a>
                </li>
                <li>
                    <a href="{$link->getPageLink('index', true, NULL, "mylogout")|escape:'html'}" title="{l s='Log me out' mod='blockuserinfo'}" class="logout" rel="nofollow">{l s='Sign out' mod='blockuserinfo'}</a>
                </li>
            {else}
                <a href="{$link->getPageLink('my-account', true)|escape:'html'}" title="{l s='Log in to your customer account' mod='blockuserinfo'}" class="login" rel="nofollow">{l s='Sign in' mod='blockuserinfo'}</a>
            {/if}
        </ul>
    </div>
</div>