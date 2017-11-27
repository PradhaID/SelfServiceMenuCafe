{% for table in tables %}
    <input id="{{ table.id }}" type="radio" name="table" value="{{ table.id }}" {% if session.get('table')==table.id %}checked{% endif %} />
    <label class="table-data visa" for="{{ table.id }}" style="left: {{ table.position_x }}%;top:{{ table.position_y }}%;">{{ table.id }}</label>
{% endfor %}
<script>
    $('input:radio[name="table"]').change(
            function(){
                if ($(this).is(':checked')) {
                    var id=$(this).val();
                    $.ajax({
                        type: "post",
                        url: "{{ url('action/table/select') }}",
                        data: { id: id},
                        success: function(result){
                            $('.select-table.modal').modal('hide');
                        }
                    });
                }
            });
</script>