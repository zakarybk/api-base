using System;
using Xunit;
using test_1;

namespace dotnet
{
    public class UnitTest1
    {
        [Fact]
        public void Test1()
        {

        }
	[Theory]
        [InlineData(3)]
        [InlineData(5)]
        [InlineData(7)]
        public void MyFirtstTheory(int myNumber)
        {
            Assert.True(Program.IsOdd(myNumber));
        }

        [Fact]
        public void PassingAddTest()
        {
            Assert.Equal(4, Program.Add(2, 2));
        }
    }
}
