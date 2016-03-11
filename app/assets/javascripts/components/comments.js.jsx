var Comment = React.createClass({
  render: function(){
      return <li>
              <p>{this.props.comment.body}</p>
              <p className="text-muted">{this.props.comment.post_id}</p>
             </li>;
  }
});
var Comments = React.createClass({
  comments: function() {
    console.log(this.props.comments);
    return this.props.comments.map(function(comment){
      return <Comment comment={comment}  />;
    });
  },
  render: function() {
    return <div>
      <ul>
        {this.comments()}
      </ul>
    </div>;
  }
});
