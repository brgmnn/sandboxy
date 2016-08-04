module Commander::UI
  def progress(arr, options = {})
    bar = ProgressBar.new(
      arr.length,
      Sandboxy::UI::PROGRESS_BAR_OPTIONS.merge(options)
    )
    bar.show
    arr.each { |v| bar.increment yield(v) }
  end
end
