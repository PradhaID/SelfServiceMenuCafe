<div class="ui middle aligned equal width stackable grid">
    <div class="equal width row">
        <div class="column">
            <h1 class="ui header">
                <i class="cubes icon"></i>
                <div class="content">
                    Product Detail
                </div>
            </h1>
        </div>
        <div class="right aligned column">
            <a class="ui small button" href="{{ url('content/product') }}"><i class="chevron left icon"></i> back to lists</a>
            <a class="ui small magenta button" href="{{ url('content/product/edit/') }}{{ id }}"><i class="edit icon"></i> Edit</a>
            <button type="button" class="ui magenta upload button"><i class="upload icon"></i> Upload Image</button>
        </div>
    </div>
</div>
<div class="ui divider"></div>
{% if status=="successadd" OR status=="success" %}
    <div class="ui positive message">
        <i class="close icon"></i>
        <div class="header">
            {% if status=="successadd" %}Your request has been succesfuly created{% else %}Your request has been succesfuly updated{% endif %}
        </div>
    </div>
    <div class="ui divider"></div>
{% endif %}
<div class="ui stackable divided grid">
    <div class="four wide column">
        <div class="ui fluid card">
            {% if images|length>0 %}
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        {% for image in images %}
                            <div class="swiper-slide">
                                <img src="{{ url('files/upload/') }}{{ date('Y',strtotime(image.created_at)) }}/{{ date('m',strtotime(image.created_at)) }}/{{ image.name }}" class="ui fluid image">
                            </div>
                        {% endfor %}
                    </div>
                    <div class="swiper-pagination"></div>
                </div>
                <script>
                    var swiper = new Swiper('.swiper-container', {
                        pagination: '.swiper-pagination',
                        paginationClickable: true
                    });
                </script>
            {% else %}
                <div class="image">
                    <img src="{{ url('img/no-image.jpg') }}">
                </div>
            {% endif %}
            <div class="content">
                <a class="header">{{ product.name }}</a>
                <div class="meta">{{ product.description }}</div>
            </div>
        </div>
    </div>
    <div class="twelve wide column">
        <div class="ui relaxed divided list">
            <div class="item">
                <div class="content">
                    <h4 class="header">Category</h4>
                    <div class="description">{{ product.category_name }}</div>
                </div>
            </div>
            <div class="item">
                <div class="content">
                    <h4 class="header">Product Name</h4>
                    <div class="description">{{ product.name }}</div>
                </div>
            </div>
            <div class="item">
                <div class="content">
                    <h4 class="header">Description</h4>
                    <div class="description">{{ product.description }}</div>
                </div>
            </div>
            <div class="item">
                <div class="content">
                    <h4 class="header">Capital Price</h4>
                    <div class="description">{{ product.capital_price|numberFormat }}</div>
                </div>
            </div>
            <div class="item">
                <div class="content">
                    <h4 class="header">Selling Price</h4>
                    <div class="description">{{ product.selling_price|numberFormat }}</div>
                </div>
            </div>
            <div class="item">
                <div class="content">
                    <h4 class="header">Created</h4>
                    <div class="description">{{ product.created_at|dateTimeFormat }} / {{ product.created_by }}</div>
                </div>
            </div>
            <div class="item">
                <div class="content">
                    <h4 class="header">Updated</h4>
                    <div class="description">{{ product.updated_at|dateTimeFormat }} / {{ product.updated_by }}</div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="ui divider"></div>
<div class="ui image modal">
    <div class="header">Add Image</div>
    <div class="content">
        <form class="ui form" name="photo" id="photo" method="post" action="{{ url('content/product/upload/') }}{{ id }}" enctype="multipart/form-data">
            <div class="field">
                <img id="preview" class="ui centered small image" />
                <div class="ui divider"></div>
                <div class="ui fluid action input">
                    <input type="text" readonly>
                    <input type="file" name="file" accept="image/*" onchange="loadFile(event)">
                    <div class="ui icon button">
                        <i class="cloud upload icon"></i>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="actions">
        <div class="ui cancel button">Cancel</div>
        <button form="photo" type="submit" class="ui submit teal button">Upload</button>
    </div>
</div>
<table class="ui mini selection striped table" id="images">
    <thead>
    <tr>
        <th>#</th>
        <th>Original Name</th>
        <th>File Name</th>
        <th>Description</th>
        <th>Content Type</th>
        <th>File Size</th>
        <th>Uploaded</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    {% for image in images %}
    <tr>
        <td>#</td>
        <td>{{ image.original_name }}</td>
        <td>{{ image.name }}</td>
        <td>{{ image.description }}</td>
        <td>{{ image.content_type }}</td>
        <td>{{ image.size }}</td>
        <td>{{ image.created_at|dateTimeFormat }}</td>
        <td>
            <i class="edit icon"></i>
            <i key="{{ image.id }}" class="trash icon"></i>
        </td>
    </tr>
    {% endfor %}
    </tbody>
</table>
<script>
    var loadFile = function(event) {
        var reader = new FileReader();
        reader.onload = function(){
            var output = document.getElementById('preview');
            output.src = reader.result;
            $('.image.modal')
                    .modal({observeChanges: true});
        };
        reader.readAsDataURL(event.target.files[0]);
    };

    $(document).ready(function(){
        $('input:text, .ui.button', '.ui.action.input')
                .on('click', function(e) {
                    $('input:file', $(e.target).parents()).click();
                })
        ;

        $('input:file', '.ui.action.input')
                .on('change', function(e) {
                    var name = e.target.files[0].name;
                    $('input:text', $(e.target).parent()).val(name);
                })
        ;
        $('.image.modal')
                .modal('attach events', '.upload.button', 'show')
        ;
        $('#images').on('click','.trash',function(){
            var value=$(this).attr('key');
            $.confirm({
                icon: 'warning icon',
                title: 'Delete Confirmation',
                content: 'Are you sure?',
                boxWidth: '500px',
                closeIcon: true,
                type: 'dark',
                theme: 'modern',
                typeAnimated: true,
                buttons: {
                    confirm: function () {
                        $.ajax({
                            type: "post",
                            url: "{{ url('content/product/delete-image') }}",
                            data: {id: value},
                            success: function(result){
                                if (result=="success")
                                    window.location.replace("{{ url('content/product/detail/') }}{{ id }}/success");
                                else
                                    alert('failed : '+result);
                            }
                        });
                    },
                    cancel: function () {
                    }
                }
            });

        })
    });
</script>