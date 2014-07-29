[![Build Status](https://api.travis-ci.org/emfigo/absplit.png)](https://api.travis-ci.org/emfigo/absplit)

ABSplit
=====

The aim of ABSplit is a form of statistical hypothesis testing based on weights given by the user. 

##Installation

 ```ruby
   gem install 'a_b_split'
 ```

##Usage

In the current version you can only use weighted split. It will be modified to use more algorithms in the future.

In order to use the gem it's necessary to initialize the configuration with all the experiments that you are going to use in your application

```ruby
  ABSplit.configure do |config|
    config.experiments = { 
                           'experimentA' => [ { 'name' => 'optionA', 
                                                'weight' => 50 },
                                              { 'name' => 'optionB' } 
                                            ] 
                         }
  end
```
Also you can set your experiments in a yml file. 

```ruby
experimentA:
  - name: 'optionA'
    weight: 50
  - name: 'optionB'
experimentB:
  - name: 'optionA'
    weight: 33.33
  - name: 'optionB'
  - name: 'optionC'
```

And load them with the following:

```ruby
  ABSplit.configure do |config|
    config.experiments = YAML.load_file File.join( File.dirname(__FILE__), *%w(.. experiments.yml))
  end
```

Once your experiments are loaded. You can use the splitter in your application

```ruby
  ABSplit::Test.split('experimentA', user_id)
```

IMPORTANT: It is important that you pass a unique  indentifier to the experiment, so when the splitting occurs it's consistent (otherwise it would act like a random). This identifier could be an id, or whatever object you consider.

##Recommendations
This gem was meant to be simple and more focused on the splitting itself, not on extra functionality. If you want to track your experiments, for example in a web page, you can use Google Analytics. Also if you want the value to be pesistent because you increment the percentage you can use http cookies.
