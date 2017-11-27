<table class="ui mini magenta striped selectable table">
    <thead>
    <tr>
        <th>Parent</th>
        <th>Name</th>
        <th>Description</th>
        <th>Created</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    {% for category in categories %}
        <tr>
            <td>{{ category.parent_name }}</td>
            <td>{{ category.name }}</td>
            <td>{{ category.description }}</td>
            <td>{{ category.created_at|dateTimeFormat }}</td>
            <td><a href="{{ url('content/category/edit/') }}{{  category.id }}">Edit</a></td>
        </tr>
    {% endfor %}
    </tbody>
</table>
<div class="ui divider"></div>