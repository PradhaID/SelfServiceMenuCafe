<form class="ui form" method="post" action="{{ url('login') }}">
    <div class="ui middle aligned center aligned grid">
        <div class="center align login">
            <img src="{{ url('img/logo.png') }}" class="ui medium centered image">

            <div class="ui stacked segment">
                <div class="field">
                    <h2 class="ui teal image header">
                        <div class="content">
                            Log-in to System
                        </div>
                    </h2>
                    <div class="ui left icon input">
                        <i class="user icon"></i>
                        <input type="text" name="usermail" placeholder="username/E-mail address">
                    </div>
                </div>
                <div class="field">
                    <div class="ui left icon input">
                        <i class="lock icon"></i>
                        <input type="password" name="password" placeholder="Password">
                    </div>
                </div>
                <button type="submit" class="ui fluid large magenta submit button">Login</button>
            </div>

            <div class="ui error message"></div>


            <div class="ui message">
                New to us? <a href="#">Sign Up</a>
            </div>
        </div>
    </div>
    <script>
        $('.ui.dropdown')
            .dropdown()
        ;
        $('.ui.form')
            .form({
                fields: {
                    usermail: {
                        identifier: 'usermail',
                        rules: [
                            {
                                type: 'empty',
                                prompt: 'please enter a usermail'
                            }
                        ]
                    },
                    password: {
                        identifier: 'password',
                        rules: [
                            {
                                type: 'empty',
                                prompt: 'please enter your password'
                            }
                        ]
                    }
                },
                inline: true,
                on: blur,
                transition: 'fade down',

            })
        ;
    </script>
</form>