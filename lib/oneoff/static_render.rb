out_dir = "/Users/steinwam/Desktop/ribbonjs/"

views = [
    # {:type => "js", :out_file => "controller.js",  :in_file => "/diagrams/_controller.js.haml"},
    # {:type => "js", :out_file => "diagram.js",  :in_file => "/diagrams/_diagram.js.haml"},
    # {:type => "js", :out_file => "filter.js",  :in_file => "/diagrams/_filter.js.haml"},
    # {:type => "js", :out_file => "format_converter.js",  :in_file => "/diagrams/_format_converter.js.haml"},
    # {:type => "js", :out_file => "graph.js",  :in_file => "/diagrams/_graph.js.haml"},
    # {:type => "js", :out_file => "link.js",  :in_file => "/diagrams/_link.js.haml"},
    # {:type => "js", :out_file => "node.js",  :in_file => "/diagrams/_node.js.haml"},
    # {:type => "js", :out_file => "view.js",  :in_file => "/diagrams/_view.js.haml"},
    {:type => "html", :out_file => "show.html",  :in_file => "/diagrams/show.html.haml"}
]


class ExtendedActionViewBase < ActionView::Base
  def render_with_instance_vars(options = {}, local_assigns = {}, &block)
    @diagram = Diagram.find(11)

    render options, local_assigns, &block
  end

  def current_user
    User.first
  end
end

class StaticRender < ActionController::Base
  def self.render_haml(template_path, params)

    view = ExtendedActionViewBase.new(ActionController::Base.view_paths, {})

    class << view
      include ApplicationHelper
    end

    view.render_with_instance_vars({:file => template_path, :layout => false}, :locals => params )
  end
end

views.each do |view|
  File.open(out_dir+view[:out_file],"w") do |file|
    file_text = StaticRender.render_haml(view[:in_file], {})

    if view[:type] == "js"
      file_text = file_text.partition('<script>').last
      file_text = file_text.gsub("<script>", "")
      file_text = file_text.gsub("</script>", "")
    end

    file.write(file_text)
  end
end


#Then run on command line
puts "Now Run the following on the command line:"
puts "~/node_modules/.bin/jsdoc --debug -d #{out_dir}/out #{out_dir}"
puts "The location of the jsdoc binary may be different for you."

