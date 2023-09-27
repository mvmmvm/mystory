class StoriesController < ApplicationController
    def index
        @stories = Story.all
    end
    def show
    end
end
