#include "component1.hh"

#include <string>
  using std::string;

#include <gmock/gmock.h>
  using ::testing::Eq;
#include <gtest/gtest.h>
  using ::testing::Test;


namespace ToDoCore
{
namespace testing
{
    class ComponentTest : public Test
    {
    protected:
        ComponentTest(){}
        ~ComponentTest(){}

        virtual void SetUp(){}
        virtual void TearDown(){}


        Bar bar;
    };


    TEST_F(ComponentTest, foo_return_test)
    {
        EXPECT_THAT(bar.foo(), Eq(111));
    }

} // namespace testing
} // namespace ToDoCore
