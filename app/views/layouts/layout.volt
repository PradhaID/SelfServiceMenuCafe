<div id="layout">
    <div class="elca-sidebar">
        <div class="ui fluid inverted magenta menu no-round">
            <div class="header title item">
                Sultan Cafe, Music, & Barber Shop
            </div>
        </div>
        <div class="inverted">
            <div class="userinfo">
                <img class="ui centered aligned circular tiny image" src="http://1.bp.blogspot.com/-MkinBQMWOQg/Vh3QhLiTMcI/AAAAAAAAAG8/rD-suQEgLsc/s1600/Gambar-Editan-Lucu-Keren-Gokil-Terbaru-34.jpg">
            <span>
                <div class="title">{{ session.get('name') }}</div>
                <div class="sub-title">Jawa Barat, Indonesia</div>
            </span>
            </div>
            <div class="ui divider"></div>

            <div class="scrollable">
                <div class="ui inverted secondary vertical fluid menu">
                    <a href="{{ url('dashboard') }}" class="item">
                        <i class="dashboard icon"></i>Admin Dashboard
                    </a>
                </div>
                <div class="ui inverted secondary vertical fluid menu">
                    <div class="header item"><i class="money icon"></i> Sale</div>
                    <a href="{{ url('sale/invoice') }}" class="{% if menu=='invoice' %}active{% endif %} item">
                        Invoice
                    </a>
                </div>
                <div class="ui inverted secondary vertical fluid menu">
                    <div class="header item"><i class="cubes icon"></i> Contents</div>
                    <a href="{{ url('content/category') }}" class="{% if menu=='category' %}active{% endif %} item">
                        Category
                    </a>
                    <a href="{{ url('content/product') }}" class="{% if menu=='product' %}active{% endif %} item">
                        Product
                    </a>
                    <a href="{{ url('content/table') }}" class="{% if menu=='table' %}active{% endif %} item">
                        Table
                    </a>
                </div>
                <div class="ui inverted secondary vertical fluid menu">
                    <div class="header item"><i class="heartbeat icon"></i> Reporting</div>
                    <a href="{{ url('reporting/sale') }}" class="{% if menu=='sale' %}active{% endif %} item">
                        Sale
                    </a>
                </div>
                <div class="ui inverted secondary vertical fluid menu">
                    <div class="header item"><i class="wrench icon"></i> System </div>
                    <a href="{{ url('system/user') }}" class="{% if menu=='user' %}active{% endif %} item">
                        Users
                    </a>
                    <a href="{{ url('system/group') }}" class="{% if menu=='group' %}active{% endif %} item">
                        Group & Roles
                    </a>
                    <a href="{{ url('system/setting') }}" class="{% if menu=='setting' %}active{% endif %} item">
                        Setting
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="elca-container">
        <div class="ui menu no-round">
            <a class="toggle button item"><i class="sidebar icon"></i> </a>
            <div class="right menu">
                <div class="ui category search item">
                    <div class="ui transparent icon input">
                        <input class="prompt" type="text" placeholder="Search animals...">
                        <i class="search link icon"></i>
                    </div>
                    <div class="results"></div>
                </div>
                <div class="ui dropdown item">
                    Hi...! {{ session.get('name') }}
                    <i class="dropdown icon"></i>
                    <div class="menu">
                        <a href="{{ url('profile') }}" class="item"><i class="user icon"></i>
                            Profile
                        </a>
                        <a href="{{ url('profile/password') }}" class="item"><i class="key icon"></i> Change Password</a>
                        <a href="{{ url('out') }}" class="item"><i class="sign out icon"></i> Sign Out</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">

            {{ content() }}

        </div>

    </div>
    <div class="clear"></div>
</div>


<script>

    $(document).ready(function(){
        $('.ui.dropdown').dropdown();

        $(function(){
            $('.toggle.button').on('click', function(){
                if( $('.elca-sidebar').is(':visible') ) {
                    $('.elca-sidebar').children().fadeOut();
                    $('.elca-sidebar').animate({ 'width': '0px' }, 'slow', function(){

                        $('.elca-sidebar').hide();

                    });
                    $('.elca-container').animate({ 'margin-left': '0px' }, 'slow');
                }
                else {
                    $('.elca-sidebar').show();
                    $('.elca-sidebar').animate({ 'width': '18%' }, 'slow');
                    $('.elca-container').animate({ 'margin-left': '18%' }, 'slow', function() {
                        $('.elca-sidebar').children().fadeIn();
                    });

                }
            });
        });
        $('.message .close')
                .on('click', function() {
                    $(this)
                            .closest('.message')
                            .transition('fade')
                    ;
                })
        ;

    })
</script>