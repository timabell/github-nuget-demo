using Xunit;

namespace GithubNugetDemo.Tests;

public class GithubNugetDemoTests
{
    [Fact]
    public void Hello_ReturnsHello()
    {
        var sut = new GithubNugetDemo();

        var result = sut.Hello();

        Assert.Equal("hello", result);
    }

    [Fact]
    public void Goodbye_ReturnsGoodbye()
    {
        var sut = new GithubNugetDemo();

        var result = sut.Goodbye();

        Assert.Equal("goodbye", result);
    }
}
