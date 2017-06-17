
{if !isset($content_only) || !$content_only}
    {if isset($HOOK_FOOTER)}
        <!-- Footer -->
        <footer id="footer">
            <div class="row">
                {$HOOK_FOOTER}
            </div>

            <div class="row">
                <div id="footer-copyright">
                    <p>
                        2016 &copy; Mon Pot Pourri. {l s='All rights reserved'}.<br/>
                        <a href="{$link->getCMSLink(17, 'conditions-generales-de-ventes')|escape:'html':'UTF-8'}">{l s='CGV & Mentions légales'}</a>
                        |
                        <a href="{$link->getCMSLink(15, 'politique-confidentialite')|escape:'html':'UTF-8'}">{l s='Politique de gestion des données personnelles'}</a>
                    </p>
                </div>
            </div>
        </footer>
        <!-- #footer -->
    {/if}
{/if}
{include file="$tpl_dir./global.tpl"}
</div><!-- end main container -->

</body>
</html>
