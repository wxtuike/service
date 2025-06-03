<?php

namespace app\common\Exception;

use think\db\exception\DataNotFoundException;
use think\db\exception\ModelNotFoundException;
use think\exception\Handle;
use think\exception\HttpException;
use think\exception\HttpResponseException;
use think\exception\ValidateException;
use app\common\Exception\ServiceException;
use think\Response;
use Throwable;

/**
 * 应用异常处理类
 */
class ExceptionHandle extends Handle
{
    /**
     * 不需要记录信息（日志）的异常类列表
     * @var array
     */
    protected $ignoreReport = [
        HttpException::class,
        HttpResponseException::class,
        ModelNotFoundException::class,
        DataNotFoundException::class,
        ValidateException::class,
        ServiceException::class
    ];

    /**
     * 记录异常信息（包括日志或者其它方式记录）
     *
     * @access public
     * @param  Throwable $exception
     * @return void
     */
    public function report(Throwable $exception): void
    {
        if (!$this->isIgnoreReport($exception)) {
            $data = [
                'file' => $exception->getFile(),
                'line' => $exception->getLine(),
                'code' => $this->getCode($exception),
                'message' => $this->getMessage($exception),
            ];
            $log = "[{$data['code']}]{$data['message']}[{$data['file']}:{$data['line']}]";
            $log .= "\r\n" . $exception->getTraceAsString();
            try {
                $this->app->log->record($log, 'error');
            } catch (\Exception $e) {
            }
        }
    }

    /**
     * Render an exception into an HTTP response.
     *
     * @access public
     * @param \think\Request   $request
     * @param Throwable $e
     * @return Response
     */
    public function render($request, Throwable $e): Response
    {
        // 添加自定义异常处理机制
        $data = new \StdClass();
        // 参数验证错误
        if ($e instanceof ValidateException) {
            return json()->data(['code' => $e->getCode(), 'info' => $e->getError(), 'data' => $data]);
        }
        //业务异常
        if ($e instanceof ServiceException) {
            return json()->data(['code' => $e->getCode(), 'info' => $e->getMessage(), 'data' => $data]);
        }
        // 请求异常
        if ($e instanceof HttpException && request()->isAjax()) {
            return response($e->getMessage(), $e->getStatusCode());
        }
        // 其他错误交给系统处理
        return parent::render($request, $e);
    }
}
