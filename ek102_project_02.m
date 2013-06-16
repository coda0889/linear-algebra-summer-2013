%{ 
EK102: Final Project - [Title Here]

Group Members: 
Jacob Janco, Trent Merrell, Stan Ng, J. Vandame, Michael Webster
%}

% Main Function
function ek102_project_00

% Global & Default Variables, Preallocation Block
global ROWS
global COLUMNS
global STEP
global DISP_MAT
global INDEX
global RESHAPE_DISP
global INDEX_COUNT
global RED_CHECK_FWD
global RED_CHECK_BWD

ROWS = 3; 
COLUMNS = 3;
INDEX = 1;
INDEX_COUNT = 0;
STEP = COLUMNS * ROWS;
RED_CHECK_FWD = 0;
RED_CHECK_BWD = 0;

data_in = zeros( 3, 3 );

% GUI ELEMENT BLOCK
f = figure;
set( f,...
    'Visible', 'off',...
    'MenuBar', 'none',...
    'Units', 'Pixels',...
    'NumberTitle','off',...
    'Name','EK 102 Final Project',...
    'Position', [ 0 0 1000 500 ],...
    'Color', [ 0.8 0.8 0.8 ],...
    'InvertHardCopy', 'off' );
  
% Row and Column editable boxes and set button
row_box = uicontrol(...
    'Style', 'edit',...
    'Position', [ 750, 400, 100, 50 ] );

col_box = uicontrol(...
    'Style', 'edit',...
    'Position', [ 875, 400, 100, 50 ] );

rxc_button = uicontrol(...
    'Style', 'pushbutton',...
    'String' , 'Set Rows and Columns',...
    'Position', [ 750, 350, 125, 25 ],...
    'CallBack', @cb_rxc_button );

% Title boxes for input and output matrix
entry_table_text = uicontrol(...
    'Style', 'text',...
    'String', 'Enter Values Here',...
    'Position', [ 50, 460, 300, 25 ] );

output_table_text = uicontrol(...
    'Style', 'text',...
    'String', 'Output Matrix',...
    'Position', [ 375, 460, 300, 25 ] );

% Main entry and output table 
entry_table = uitable(...
    'Data', data_in,...
    'Position', [ 50, 250, 300, 200 ],...
    'ColumnWidth', {30},...
    'ColumnEditable', [ true true true ] );

output_table = uitable(...
    'Data', data_in,...
    'Position', [ 375, 250 300, 200 ],...
    'ColumnWidth', {30} );
   
% Text box that prints huge matrix of all steps concatenated 
mock_cout = uicontrol(...
    'Style', 'edit',...
    'Enable', 'inactive',...
    'Max', 2,...
    'Position', [ 50, 25, 300, 200 ] );

% Shows first, second, third steps in order
history_step00 = uicontrol(...
    'Style', 'edit',...
    'Enable', 'inactive',...
    'Max', 2,...
    'Position', [ 375, 25, 200, 200 ] );

history_step01 = uicontrol(...
    'Style', 'edit',...
    'Enable', 'inactive',...
    'Max', 2,...
    'Position', [ 580, 25, 200, 200 ] );

history_step02 = uicontrol(...
    'Style', 'edit',...
    'Enable', 'inactive',...
    'Max', 2,...
    'Position', [ 785, 25, 200, 200 ] );

% Button controlling forward step
step_fwd = uicontrol(...
    'Style', 'pushbutton',...
    'Max', 2,...
    'String', 'Forward',...
    'Callback', @cb_step_fwd,...
    'Position', [ 885, 230, 75, 25 ] );

% Button controlling backward step
step_bwd = uicontrol(...
    'Style', 'pushbutton',...
    'Max', 2,...
    'String', 'Backward',...
    'Callback', @cb_step_bwd,...
    'Position', [ 800, 230, 75, 25 ] );

% Step titles, will change in accordance to current step
step00_txt = uicontrol(...
    'Style', 'text',...
    'String', strcat( 'Step:', num2str( INDEX_COUNT ) ),...
    'Position', [ 375, 25, 50, 25] );

step01_txt = uicontrol(...
    'Style', 'text',...
    'String', strcat( 'Step:', num2str( INDEX_COUNT + 1 ) ),...
    'Position', [ 580, 25, 50, 25] );

step02_txt = uicontrol(...
    'Style', 'text',...
    'String', strcat( 'Step:', num2str( INDEX_COUNT + 2 ) ),...
    'Position', [ 785, 25, 50, 25] );

% Operation buttons
op00 = uicontrol(...
    'Style', 'pushbutton',...
    'String' , 'op00',...
    'Position', [ 750, 300, 75, 25 ],...
    'CallBack', @cb_op00 );

op01 = uicontrol(...
    'Style', 'pushbutton',...
    'String' , 'op01',...
    'Position', [ 830, 300, 75, 25 ],...
    'CallBack', @cb_op01 );

op02 = uicontrol(...
    'Style', 'pushbutton',...
    'String' , 'op02',...
    'Position', [ 750, 270, 75, 25 ],...
    'CallBack', @cb_op02 );

movegui( f, 'center' )
set( f, 'visible', 'on' ) 

% Callback for row and column button
function cb_rxc_button( ~, ~ )
    set ( entry_table, 'Visible', 'off' ) 

    ROWS = str2double( get( row_box, 'String' ) );
    COLUMNS = str2double( get( col_box, 'String' ) );

    data_in = zeros( ROWS, COLUMNS );

    col_edit_string = true( 1, COLUMNS );

    set( entry_table,...
        'ColumnEditable', col_edit_string,...
        'Data', data_in,...
        'Visible', 'on' ) 
end

% Forward history step callback
function cb_step_fwd( ~, ~ )
    set( history_step00, 'Visible', 'off' )
    set( history_step01, 'Visible', 'off' )
    set( history_step02, 'Visible', 'off' )


    if INDEX < ( length( RESHAPE_DISP ) - 4 * STEP ) && INDEX_COUNT ~= 0 
        INDEX = INDEX + STEP + 1;
        INDEX_COUNT = INDEX_COUNT + 1;
    elseif INDEX_COUNT == 0

    else
        set( step_fwd,...
            'BackgroundColor', [ 1 0 0 ] )
        RED_CHECK_FWD = 1;
    end

    temp_mat00 = RESHAPE_DISP( INDEX:INDEX + STEP );
    temp_mat01 = RESHAPE_DISP( ( INDEX + STEP + 1 ):( INDEX + 1 + 2 * STEP ) );
    temp_mat02 = RESHAPE_DISP( ( INDEX + 2 + 2 * STEP ):( INDEX + 2 + 3 * STEP ) );
    disp_matrix00 = transpose( reshape( temp_mat00, COLUMNS, ROWS ) ); 
    disp_matrix01 = transpose( reshape( temp_mat01, COLUMNS, ROWS ) ); 
    disp_matrix02 = transpose( reshape( temp_mat02, COLUMNS, ROWS ) ); 

    set( history_step00,...
        'String', num2str( disp_matrix00 ),...
        'Visible', 'on' )

    set( history_step01,...
        'String', num2str( disp_matrix01 ),...
        'Visible', 'on' )

    set( history_step02,...
        'String', num2str( disp_matrix02 ),...
        'Visible', 'on' )

    step00_txt = uicontrol(...
        'Style', 'text',...
        'String', strcat( 'Step:', num2str( INDEX_COUNT ) ),...
        'Position', [ 375, 25, 50, 25] );

    step01_txt = uicontrol(...
        'Style', 'text',...
        'String', strcat( 'Step:', num2str( INDEX_COUNT + 1 ) ),...
        'Position', [ 580, 25, 50, 25] );

    step02_txt = uicontrol(...
        'Style', 'text',...
        'String', strcat( 'Step:', num2str( INDEX_COUNT + 2 ) ),...
        'Position', [ 785, 25, 50, 25] );

    if INDEX_COUNT == 0
        INDEX_COUNT = 1;
    end

    if RED_CHECK_BWD == 1
        set( step_bwd,...
            'BackgroundColor', 'default' )
        RED_CHECK_BWD = 0;
    end

end

% Backward history button callback function
function cb_step_bwd( ~, ~ )
    set( history_step00, 'Visible', 'off' )
    set( history_step01, 'Visible', 'off' )
    set( history_step02, 'Visible', 'off' )
    disp(INDEX)

    if INDEX > 1
        INDEX = INDEX - ( STEP + 1 );
        INDEX_COUNT = INDEX_COUNT - 1;
    else
        set( step_bwd,...
            'BackgroundColor', [ 1 0 0 ] )
        RED_CHECK_BWD = 1;
        INDEX_COUNT = 0;
    end

    temp_mat00 = RESHAPE_DISP( INDEX:INDEX + STEP );
    temp_mat01 = RESHAPE_DISP( ( INDEX + STEP + 1 ):( INDEX + 1 + 2 * STEP ) );
    temp_mat02 = RESHAPE_DISP( ( INDEX + 2 + 2 * STEP ):( INDEX + 2 + 3 * STEP ) );
    disp_matrix00 = transpose( reshape( temp_mat00, COLUMNS, ROWS ) ); 
    disp_matrix01 = transpose( reshape( temp_mat01, COLUMNS, ROWS ) ); 
    disp_matrix02 = transpose( reshape( temp_mat02, COLUMNS, ROWS ) ); 

    set( history_step00,...
        'String', num2str( disp_matrix00 ),...
        'Visible', 'on' )

    set( history_step01,...
        'String', num2str( disp_matrix01 ),...
        'Visible', 'on' )

    set( history_step02,...
        'String', num2str( disp_matrix02 ),...
        'Visible', 'on' )

    step00_txt = uicontrol(...
        'Style', 'text',...
        'String', strcat( 'Step:', num2str( INDEX_COUNT ) ),...
        'Position', [ 375, 25, 50, 25] );

    step01_txt = uicontrol(...
        'Style', 'text',...
        'String', strcat( 'Step:', num2str( INDEX_COUNT + 1 ) ),...
        'Position', [ 580, 25, 50, 25] );

    step02_txt = uicontrol(...
        'Style', 'text',...
        'String', strcat( 'Step:', num2str( INDEX_COUNT + 2 ) ),...
        'Position', [ 785, 25, 50, 25] )

    if RED_CHECK_FWD == 1
        set( step_fwd,...
            'BackgroundColor', 'default' )
        RED_CHECK_FWD = 0;
    end

end

function cb_op00( ~, ~ )
    set ( mock_cout, 'Visible', 'off' )
    set ( output_table, 'Visible', 'off' ) 
    set( history_step00, 'Visible', 'off' )
    set( history_step01, 'Visible', 'off' )
    set( history_step02, 'Visible', 'off' )

    % Pull data from input matrix
    temp_mat = get( entry_table, 'Data' );

    % Set globals
    INDEX = 1;
    STEP = COLUMNS * ROWS - 1;
    DISP_MAT = temp_mat;
    INDEX_COUNT = 0;

    % OPERATION START: Scalar Multiplication by 2 

    %{ 
    TO PROPERLY DISPLAY 
    - temp_mat is the name of your matrix as you make changes to it 
      temp_mat is initially drawn directly from the table that the user inputs
      values into...do your operations on temp_mat
    - DISP_MAT = vertcat( DISP_MAT, TEMP_MAT ) 
        - This code concatenates your starting matrix with each change 
          to your temp_mat...your code must update temp_mat with 1 value for 
          each step...representing 1 operation...for this example...temp_mat
          has 1 element multiplied by 2 and temp_mat is updated....DISP_MAT
          then concatenates the whole temp_mat to show how the matrix changed
    - As long as you do this you do not need to worry about code before 
      the comments % OPERATION START and % OPERATION END
    %} 
    
    for i = 1:ROWS 
        for j = 1:COLUMNS
            temp_mat( i, j ) = temp_mat ( i, j ) * 2;
            % Display matrix code here...records each step
            DISP_MAT = vertcat( DISP_MAT, temp_mat );
        end
    end

    % OPERATION END

    % Data to be fed into history functions
    RESHAPE_DISP = reshape( DISP_MAT', 1, [] );
    
    % Data displayed on mock_cout
    set( mock_cout,...
        'String', num2str( DISP_MAT ),...
        'Visible', 'on' )

    % Data initial display on history steps
    cb_step_fwd()

    % Data displayed on output matrix 
    op_data = temp_mat;
    set( output_table,...
        'Data', op_data,...
        'Visible', 'on' ) 
        
    % Reset any error display 
    RED_CHECK_FWD = 0;
    RED_CHECK_BWD = 0;

    set( step_fwd,...
        'BackgroundColor', 'default' )
    set( step_bwd,...
        'BackgroundColor', 'default' )
end

function cb_op01( ~, ~ )
    set ( mock_cout, 'Visible', 'off' )
    set ( output_table, 'Visible', 'off' ) 
    set( history_step00, 'Visible', 'off' )
    set( history_step01, 'Visible', 'off' )
    set( history_step02, 'Visible', 'off' )

    % Pull data from input matrix
    temp_mat = get( entry_table, 'Data' );

    % Set globals
    INDEX = 1;
    STEP = COLUMNS * ROWS - 1;
    DISP_MAT = temp_mat;
    INDEX_COUNT = 0;

    % OPERATION START:

    %{
    TO PROPERLY DISPLAY 
    - temp_mat is the name of your matrix as you make changes to it 
      temp_mat is initially drawn directly from the table that the user inputs
      values into...do your operations on temp_mat
    - DISP_MAT = vertcat( DISP_MAT, TEMP_MAT ) 
        - This code concatenates your starting matrix with each change 
          to your temp_mat...your code must update temp_mat with 1 value for 
          each step...representing 1 operation...for this example...temp_mat
          has 1 element multiplied by 2 and temp_mat is updated....DISP_MAT
          then concatenates the whole temp_mat to show how the matrix changed
    - As long as you do this you do not need to worry about code before 
      the comments % OPERATION START and % OPERATION END
    %} 

    % OPERATION END

    % Data to be fed into history functions
    RESHAPE_DISP = reshape( DISP_MAT', 1, [] );
    
    % Data displayed on mock_cout
    set( mock_cout,...
        'String', num2str( DISP_MAT ),...
        'Visible', 'on' )

    % Data initial display on history steps
    cb_step_fwd()

    % Data displayed on output matrix 
    op_data = temp_mat;
    set( output_table,...
        'Data', op_data,...
        'Visible', 'on' ) 

    % Reset any error display 
    RED_CHECK_FWD = 0;
    RED_CHECK_BWD = 0;

    set( step_fwd,...
        'BackgroundColor', 'default' )
    set( step_bwd,...
        'BackgroundColor', 'default' )
end

function cb_op02( ~, ~ )
    set ( mock_cout, 'Visible', 'off' )
    set ( output_table, 'Visible', 'off' ) 
    set( history_step00, 'Visible', 'off' )
    set( history_step01, 'Visible', 'off' )
    set( history_step02, 'Visible', 'off' )

    % Pull data from input matrix
    temp_mat = get( entry_table, 'Data' );

    % Set globals
    INDEX = 1;
    STEP = COLUMNS * ROWS - 1;
    DISP_MAT = temp_mat;
    INDEX_COUNT = 0;

    % OPERATION START: 

    %{
    TO PROPERLY DISPLAY 
    - temp_mat is the name of your matrix as you make changes to it 
      temp_mat is initially drawn directly from the table that the user inputs
      values into...do your operations on temp_mat
    - DISP_MAT = vertcat( DISP_MAT, TEMP_MAT ) 
        - This code concatenates your starting matrix with each change 
          to your temp_mat...your code must update temp_mat with 1 value for 
          each step...representing 1 operation...for this example...temp_mat
          has 1 element multiplied by 2 and temp_mat is updated....DISP_MAT
          then concatenates the whole temp_mat to show how the matrix changed
    - As long as you do this you do not need to worry about code before 
      the comments % OPERATION START and % OPERATION END
    %} 
    
    % OPERATION END

    % Data to be fed into history functions
    RESHAPE_DISP = reshape( DISP_MAT', 1, [] );
    
    % Data displayed on mock_cout
    set( mock_cout,...
        'String', num2str( DISP_MAT ),...
        'Visible', 'on' )

    % Data initial display on history steps
    cb_step_fwd()

    % Data displayed on output matrix 
    op_data = temp_mat;
    set( output_table,...
        'Data', op_data,...
        'Visible', 'on' ) 

    % Reset any error display 
    RED_CHECK_FWD = 0;
    RED_CHECK_BWD = 0;

    set( step_fwd,...
        'BackgroundColor', 'default' )
    set( step_bwd,...
        'BackgroundColor', 'default' )

end

end
