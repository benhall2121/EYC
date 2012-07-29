class SurveysController < ApplicationController
  before_filter :require_login, :except => [:show, :index, :take_survey_new, :take_survey_create, :survey_answer]
  
  def index
    @surveys = Survey.find(:all, :order => 'created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @surveys }
    end
  end

  # GET /surveys/1
  # GET /surveys/1.xml
  def show
    @survey = Survey.find(params[:id])
    @survey_response = @survey.survey_responses.find(:all, :order => 'question_id, content')
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @survey }
    end
  end

  # GET /surveys/new
  # GET /surveys/new.xml
  def new
    @survey = Survey.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @survey }
    end
  end

  # GET /surveys/1/edit
  def edit
    @survey = Survey.find(params[:id])
  end

  # POST /surveys
  # POST /surveys.xml
  def create
    @survey = Survey.new(params[:survey])

    respond_to do |format|
      if @survey.save
        format.html { redirect_to(@survey, :notice => 'Survey was successfully created.') }
        format.xml  { render :xml => @survey, :status => :created, :location => @survey }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @survey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /surveys/1
  # PUT /surveys/1.xml
  def update
    @survey = Survey.find(params[:id])
    
    respond_to do |format|
      if @survey.update_attributes(params[:survey])
        format.html { redirect_to(@survey, :notice => 'Survey was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @survey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.xml
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy

    respond_to do |format|
      format.html { redirect_to(surveys_url) }
      format.xml  { head :ok }
    end
  end
  
  def take_survey_new
    @survey = Survey.find(params[:id])
    
    @survey.questions.count.times do
      @rs = SurveyResponse.new
    end
  end
  
  def take_survey_create
    survey_id = 0

    assoc_value = random_alphanumeric(21)
     params[:survey_responses].values.each do |a|  
       a[:assoc_value] = assoc_value 
       @survey_response = SurveyResponse.new(a)
       @survey_response.save if !a[:answer_id].blank?
       survey_id = a[:survey_id]
     end
     
     redirect_to survey_answer_path(:survey_id => survey_id, :assoc_value => assoc_value)
  end

  def survey_answer

    if !params[:assoc_value].nil?
      @survey_responses = SurveyResponse.find(:all, :conditions => ['assoc_value = ?', params[:assoc_value]])
      total_score = 0
      @survey_responses.each do |ts|
        total_score = total_score + ts.answer.score
      end

      @final_answer = ScoreAnswer.find(:first, :conditions => ['survey_id = ? AND start_range <= ? AND (end_range >= ? OR end_range is NULL)', params[:survey_id], total_score, total_score]).content
    else
      @final_answer = "What did YOU do wrong? Clearly, it was your fault because we have no feed back for you!"
    end

  end
  
end
